// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectBloom(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Bloom";
	static __priority = 11;
	static __shaderCutoff = __shd_screenFX_bloom_cutoff;
	static __shaderBlurH = __shd_screenFX_bloom_blur_h;
	static __shaderBlurV = __shd_screenFX_bloom_blur_v;
	static _uBloomSizeH = shader_get_uniform(__shaderBlurH, "u_bloom_size");
	static _uBloomSizeV = shader_get_uniform(__shaderBlurV, "u_bloom_size");
	static _uBloomCutoff = shader_get_uniform(__shaderCutoff, "u_bloom_cutoff");
	static _uBloomAmount = shader_get_uniform(__shaderCutoff, "u_bloom_amount");

	static __CleanupCallback = function() {
		if (surface_exists(__surfaceBrightness)) surface_free(__surfaceBrightness);
		if (surface_exists(__surfaceBlurH)) surface_free(__surfaceBlurH);
		if (surface_exists(__surfaceBlurV)) surface_free(__surfaceBlurV);
	};

	static __PrepareSurfaces = function(_width, _height, _format) {
		if (surface_exists(__surfaceBrightness)) && (surface_get_format(__surfaceBrightness) != _format) {
			surface_free(__surfaceBrightness);
			surface_free(__surfaceBlurH);
			surface_free(__surfaceBlurV);
		}

		if (!surface_exists(__surfaceBrightness)) __surfaceBrightness = surface_create(_width, _height, _format);
		if (!surface_exists(__surfaceBlurH)) __surfaceBlurH = surface_create(_width, _height, _format);
		if (!surface_exists(__surfaceBlurV)) __surfaceBlurV = surface_create(_width, _height, _format);		

		if (surface_get_width(__surfaceBrightness) != _width) || (surface_get_height(__surfaceBrightness) != _height) {
			surface_resize(__surfaceBrightness, _width, _height);
			surface_resize(__surfaceBlurH, _width, _height);
			surface_resize(__surfaceBlurV, _width, _height);
		}
	};

	__surfaceBrightness = handle_parse("ref surface -1");
	__surfaceBlurH = handle_parse("ref surface -1");
	__surfaceBlurV = handle_parse("ref surface -1");

	ScreenFXEffectVarsEnsure(
		"bloom_size", 5,
		"bloom_cutoff", 0.5,
		"bloom_amount", 0.5
	);

	static __Apply = function(_surf, _time) {
		__PrepareSurfaces(surface_get_width(_surf), surface_get_height(_surf), surface_get_format(_surf));

		surface_set_target(__surfaceBrightness);
			draw_clear_alpha(c_black, 0);
			shader_set(__shaderCutoff);
			shader_set_uniform_f(_uBloomCutoff, vars.bloom_cutoff);
			shader_set_uniform_f(_uBloomAmount, vars.bloom_amount);
			draw_surface(_surf, 0, 0);
			shader_reset();
		surface_reset_target();

		surface_set_target(__surfaceBlurH);
			draw_clear_alpha(c_black, 0);
			shader_set(__shaderBlurH);
			shader_set_uniform_f(_uBloomSizeH, vars.bloom_size);
			draw_surface(__surfaceBrightness, 0, 0);
			shader_reset();
		surface_reset_target();

		surface_set_target(__surfaceBlurV);
			draw_clear_alpha(c_black, 0);
			shader_set(__shaderBlurV);
			shader_set_uniform_f(_uBloomSizeV, vars.bloom_size);
			draw_surface(__surfaceBlurH, 0, 0);
			shader_reset();
		surface_reset_target();

		draw_surface(_surf, 0, 0);
		gpu_set_blendmode(bm_max);
		draw_surface(__surfaceBlurV, 0, 0);
		gpu_set_blendmode(bm_normal);
	};
}