// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectGaussianBlur(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Gaussian Blur";
	static __priority = 12;
	static __shaderBlurH = __shd_screenFX_gaussian_blur_h;
	static __shaderBlurV = __shd_screenFX_gaussian_blur_v;
	static _uBlurRadiusH = shader_get_uniform(__shaderBlurH, "u_blur_radius");
	static _uBlurRadiusV = shader_get_uniform(__shaderBlurV, "u_blur_radius");
	static _uBlurTextureSizeH = shader_get_uniform(__shaderBlurH, "u_texture_size");
	static _uBlurTextureSizeV = shader_get_uniform(__shaderBlurV, "u_texture_size");

	static __CleanupCallback = function() {
		if (surface_exists(__surfaceBlurH)) surface_free(__surfaceBlurH);
		if (surface_exists(__surfaceBlurV)) surface_free(__surfaceBlurV);
	};

	static __PrepareSurfaces = function(_width, _height, _format) {
		if (surface_exists(__surfaceBlurH)) && (surface_get_format(__surfaceBlurH) != _format) {
			surface_free(__surfaceBlurH);
			surface_free(__surfaceBlurV);
		}

		if (!surface_exists(__surfaceBlurH)) __surfaceBlurH = surface_create(_width, _height, _format);
		if (!surface_exists(__surfaceBlurV)) __surfaceBlurV = surface_create(_width, _height, _format);		

		if (surface_get_width(__surfaceBlurH) != _width) || (surface_get_height(__surfaceBlurH) != _height) {
			surface_resize(__surfaceBlurH, _width, _height);
			surface_resize(__surfaceBlurV, _width, _height);
		}
	};

	__surfaceBlurH = handle_parse("ref surface -1");
	__surfaceBlurV = handle_parse("ref surface -1");

	ScreenFXEffectVarsEnsure(
		"blur_radius_h", 3,
		"blur_radius_v", 3,
	);

	static __Apply = function(_surf, _time) {
		__PrepareSurfaces(surface_get_width(_surf), surface_get_height(_surf), surface_get_format(_surf));

		var _width = surface_get_width(_surf), _height = surface_get_height(_surf);

		surface_set_target(__surfaceBlurH);
			draw_clear_alpha(c_black, 0);
			shader_set(__shaderBlurH);
			shader_set_uniform_f(_uBlurRadiusH, vars.blur_radius_h);
			shader_set_uniform_f(_uBlurTextureSizeH, _width, _height);
			draw_surface(_surf, 0, 0);
			shader_reset();
		surface_reset_target();

		surface_set_target(__surfaceBlurV);
			draw_clear_alpha(c_black, 0);
			shader_set(__shaderBlurV);
			shader_set_uniform_f(_uBlurRadiusV, vars.blur_radius_v);
			shader_set_uniform_f(_uBlurTextureSizeV, _width, _height);
			draw_surface(__surfaceBlurH, 0, 0);
			shader_reset();
		surface_reset_target();

		draw_surface(_surf, 0, 0);
		gpu_set_blendmode(bm_max);
		draw_surface(__surfaceBlurV, 0, 0);
		gpu_set_blendmode(bm_normal);
	};
}