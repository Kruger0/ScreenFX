function ScreenFXVignetteEffect(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "ScreenFXInvert";
	static __priority = 4;
	static __shader = shd_screenFX_vignette;
	static _uAmount = shader_get_uniform(__shader, "u_Amount");
	static _uFalloff = shader_get_uniform(__shader, "u_Falloff");

	ScreenFXEffectVarsEnsure(
		"amount", 0.5,
		"falloff", 0.5,
	);

	static Apply = function(_surf) {
		shader_set(__shader);
		shader_set_uniform_f(_uAmount, vars.amount);
		shader_set_uniform_f(_uFalloff, vars.falloff);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}