/// @param {Struct} vars
function ScreenFXEffectContrast(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Contrast";
	static __priority = 7;
	static __shader = __shd_screenFX_contrast;
	static _uContrast = shader_get_uniform(__shader, "u_contrast");

	ScreenFXEffectVarsEnsure(
		"contrast", 1,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uContrast, vars.contrast);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}