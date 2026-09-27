// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectSimpleShader(_vars) : ScreenFXBaseEffectClass(_vars) constructor {
	ScreenFXEffectVarsEnsure(
		"shader", __shd_screenFX_passthrough
	);

	static GetName = function() {
		return shader_get_name(vars.shader);
	};

	static __Apply = function(_surf, _time) {
		shader_set(vars.shader);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}
