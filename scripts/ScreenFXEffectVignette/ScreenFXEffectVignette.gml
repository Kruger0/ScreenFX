// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectVignette(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Vignette";
	static __priority = 4;
	static __shader = __shd_screenFX_vignette;
	static _uAmount = shader_get_uniform(__shader, "u_amount");
	static _uFalloff = shader_get_uniform(__shader, "u_falloff");

	ScreenFXEffectVarsEnsure(
		"amount", 0.5,
		"falloff", 0.5,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uAmount, vars.amount);
		shader_set_uniform_f(_uFalloff, vars.falloff);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}