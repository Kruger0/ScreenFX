function ScreenFXInvertEffectClass(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "ScreenFXInvert";
	static __priority = 1;
	static __shader = shd_screenFX_invert;

	ScreenFXEffectVarsEnsure(
		"mix", 1,
	);

	static Apply = function(_surf) {
		shader_set(__shader);
		//shader_set_uniform_f(_uSaturation, vars.mix);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}