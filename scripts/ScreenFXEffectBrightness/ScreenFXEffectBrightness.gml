/// @param {Struct} vars
function ScreenFXEffectBrightness(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Brightness";
	static __priority = 5;
	static __shader = __shd_screenFX_brightness;
	static _uBrightness = shader_get_uniform(__shader, "u_brightness");

	ScreenFXEffectVarsEnsure(
		"brightness", 0,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uBrightness, vars.brightness);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}