/// @param {Struct} vars
function ScreenFXEffectGrayscale(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Grayscale";
	static __priority = 3;
	static __shader = __shd_screenFX_grayscale;
	static _uSaturation = shader_get_uniform(__shader, "u_saturation");

	ScreenFXEffectVarsEnsure(
		"saturation", 0,
	);

	static Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uSaturation, vars.saturation);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}