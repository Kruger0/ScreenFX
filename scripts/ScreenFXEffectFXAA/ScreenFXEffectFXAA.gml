/// @param {Struct} vars
function ScreenFXEffectFXAA(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "FXAA";
	static __priority = 4;
	static __shader = __shd_screenFX_fxaa;
	static _uResolution = shader_get_uniform(__shader, "u_resolution");
	static _uStrength = shader_get_uniform(__shader, "u_strength");

	ScreenFXEffectVarsEnsure(
		"strength", 1,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uResolution, surface_get_width(_surf), surface_get_height(_surf));
		shader_set_uniform_f(_uStrength, vars.strength);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}