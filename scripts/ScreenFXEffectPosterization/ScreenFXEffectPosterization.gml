/// @param {Struct} vars
function ScreenFXEffectPosterization(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Posterization";
	static __priority = 6;
	static __shader = __shd_screenFX_posterization;
	static _uPosterization = shader_get_uniform(__shader, "u_posterizationLevel");

	ScreenFXEffectVarsEnsure(
		"posterizationLevel", 4,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uPosterization, vars.posterizationLevel);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}