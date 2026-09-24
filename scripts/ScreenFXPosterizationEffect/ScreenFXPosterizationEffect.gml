function ScreenFXPosterizationEffect(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "ScreenFXPosterization";
	static __priority = 6;
	static __shader = shd_screenFX_posterization;
	static _uPosterization = shader_get_uniform(__shader, "u_PosterizationLevel");

	ScreenFXEffectVarsEnsure(
		"posterizationLevel", 4,
	);

	static Apply = function(_surf) {
		shader_set(__shader);
		shader_set_uniform_f(_uPosterization, vars.posterizationLevel);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}