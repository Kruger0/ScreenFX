/// @param {Struct} vars
function ScreenFXEffectGamma(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Gamma";
	static __priority = 6;
	static __shader = __shd_screenFX_gamma;
	static _uGamma = shader_get_uniform(__shader, "u_gamma");

	ScreenFXEffectVarsEnsure(
		"gamma", 1,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uGamma, vars.gamma);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}