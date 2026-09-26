/// @param {Struct} vars
function ScreenFXEffectColourTint(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Tint";
	static __priority = 2;
	static __shader = __shd_screenFX_colour_tint;

	static _uRgba = shader_get_uniform(__shader, "u_rgba");
	static _uMix = shader_get_uniform(__shader, "u_mix");

	ScreenFXEffectVarsEnsure(
		"colour", c_white,
		"alpha", 1,
		"mix", 0.5,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uRgba, colour_get_red(vars.colour) / 255, colour_get_green(vars.colour) / 255, colour_get_blue(vars.colour) / 255, min(vars.alpha, 1));
		shader_set_uniform_f(_uMix, vars.mix);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}