/// @param {Struct} vars
function ScreenFXEffectPixelate(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Pixelate";
	static __priority = 6;
	static __shader = __shd_screenFX_pixelate;
	static _uAmount = shader_get_uniform(__shader, "u_amount");
	static _uResolution = shader_get_uniform(__shader, "u_resolution");

	ScreenFXEffectVarsEnsure(
		"amount", 32,
	);

	static Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uAmount, vars.amount);
		shader_set_uniform_f(_uResolution, surface_get_width(_surf), surface_get_height(_surf));
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}