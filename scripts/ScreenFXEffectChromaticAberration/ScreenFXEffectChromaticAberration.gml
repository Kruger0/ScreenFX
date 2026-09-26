/// @param {Struct} vars
function ScreenFXEffectChromaticAberration(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Chromatic Aberration";
	static __priority = 4;
	static __shader = __shd_screenFX_chromatic_aberration;
	static _uSamples = shader_get_uniform(__shader, "u_samples");
	static _uContrast = shader_get_uniform(__shader, "u_contrast");
	static _uOffset = shader_get_uniform(__shader, "u_offset");

	ScreenFXEffectVarsEnsure(
		"samples", 20,
		"xoffset", 0.03,
		"yoffset", 0.03,
		"contrast", 2.0,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uSamples, vars.samples);
		shader_set_uniform_f(_uContrast, vars.contrast);
		shader_set_uniform_f(_uOffset, vars.xoffset, vars.yoffset);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}