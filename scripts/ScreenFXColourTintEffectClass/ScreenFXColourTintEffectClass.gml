function ScreenFXColourTintEffectClass(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "ScreenFXTint";
	static __priority = 2;
	static __shader = shd_screenFX_colour_tint;

	static _uRgba = shader_get_uniform(__shader, "u_Rgba");
	static _uMix = shader_get_uniform(__shader, "u_Mix");

	ScreenFXEffectVarsEnsure(
		"colour", c_white,
		"alpha", 1,
		"mix", 0.5,
	);

	static Apply = function(_surf) {
		shader_set(__shader);
		shader_set_uniform_f(_uRgba, colour_get_red(vars.colour) / 255, colour_get_green(vars.colour) / 255, colour_get_blue(vars.colour) / 255, min(vars.alpha, 1));
		shader_set_uniform_f(_uMix, vars.mix);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}