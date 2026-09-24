function ScreenFXSaturationEffectClass(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "ScreenFXSaturation";
	static __priority = 3;
	static __shader = shd_screenFX_saturation;
	static _uSaturation = shader_get_uniform(__shader, "u_Saturation");

	ScreenFXEffectVarsEnsure(
		"saturation", 0.5,
	);

	static Apply = function(_surf) {
		shader_set(__shader);
		shader_set_uniform_f(_uSaturation, vars.saturation);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}