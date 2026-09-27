// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectHsv(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Hsv";
	static __priority = 8;
	static __shader = __shd_screenFX_hsv;
	static _uHsv = shader_get_uniform(__shader, "u_hsv");

	ScreenFXEffectVarsEnsure(
		"hue", 255,
		"saturation", 255,
		"value", 255,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uHsv, vars.hue / 255, vars.saturation / 255, vars.value / 255);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}