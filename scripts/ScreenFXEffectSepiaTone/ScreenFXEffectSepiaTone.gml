/// @param {Struct} vars
function ScreenFXEffectSepiaTone(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Tone";
	static __priority = 3;
	static __shader = __shd_screenFX_sepia_tone;
	static _uTone = shader_get_uniform(__shader, "u_tone");

	ScreenFXEffectVarsEnsure(
		"colour", #704214,
		"mix", 0.5
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uTone, colour_get_red(vars.colour) / 255, colour_get_green(vars.colour) / 255, colour_get_blue(vars.colour) / 255, vars.mix);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}