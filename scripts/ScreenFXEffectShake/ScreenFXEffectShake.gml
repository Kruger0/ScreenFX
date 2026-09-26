/// @param {Struct} vars
function ScreenFXEffectShake(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Shake";
	static __priority = 9_999_999;
	static __shader = __shd_screenFX_shake;
	static _uPos = shader_get_uniform(__shader, "u_pos");

	ScreenFXEffectVarsEnsure(
		"xoffset", 5,
		"yoffset", 5,
		"timescale", 1,
	);

	static Apply = function(_surf, _time) {
		var _timeValue = (_time * vars.timescale);
		var _texture = surface_get_texture(_surf);
		var _xpos = texture_get_texel_width(_texture) * (vars.xoffset * cos(_timeValue));
		var _ypos = texture_get_texel_height(_texture) * (vars.yoffset * sin(_timeValue));

		shader_set(__shader);
		shader_set_uniform_f(_uPos, _xpos, _ypos);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}