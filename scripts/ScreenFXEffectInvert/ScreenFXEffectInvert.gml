/// @param {Struct} vars
function ScreenFXEffectInvert(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Invert";
	static __priority = 1;
	static __shader = __shd_screenFX_invert;
	static _uMix = shader_get_uniform(__shader, "u_mix");

	ScreenFXEffectVarsEnsure(
		"mix", 1,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uMix, vars.mix);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}