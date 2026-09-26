/// @param {Struct} vars
function ScreenFXEffectHueShift(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Hue Shift";
	static __priority = 8;
	static __shader = __shd_screenFX_hue_shift;
	static _uShift = shader_get_uniform(__shader, "u_shift");

	ScreenFXEffectVarsEnsure(
		"shift", 0,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uShift, vars.shift);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}