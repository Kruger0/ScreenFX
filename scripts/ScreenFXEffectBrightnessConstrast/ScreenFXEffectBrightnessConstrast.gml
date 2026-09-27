// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectBrightnessConstrast(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Brightness Contrast";
	static __priority = 4;
	static __shader = __shd_screenFX_brightness_contrast;
	static _uBrightness = shader_get_uniform(__shader, "u_brightness");
	static _uContrast = shader_get_uniform(__shader, "u_contrast");

	ScreenFXEffectVarsEnsure(
		"brightness", 1,
		"contrast", 1,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uBrightness, vars.brightness);
		shader_set_uniform_f(_uContrast, vars.contrast);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}