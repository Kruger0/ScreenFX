function ScreenFXSaturationEffectClass(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "ScreenFXSaturation";
	static __priority = 1;
	static __shader = shd_screenFX_saturation;
	ScreenFXEffectVarsEnsure(
		"saturation", 0.5,
	);

	static uSaturation = shader_get_uniform(__shader, "u_Saturation");

	static Apply = function(_surf) {
		shader_set(__shader);
		shader_set_uniform_f(uSaturation, vars.saturation);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}