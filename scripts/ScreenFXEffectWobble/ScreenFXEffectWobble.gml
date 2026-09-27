// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectWobble(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Wobble";
	static __priority = 100_000;
	static __shader = __shd_screenFX_wobble;
	static _uTime = shader_get_uniform(__shader, "u_time");
	static _uFrames = shader_get_uniform(__shader, "u_frames");
	static _uSpeed = shader_get_uniform(__shader, "u_speed");
	static _uStrength = shader_get_uniform(__shader, "u_strength");
	static _uFlowMap = shader_get_sampler_index(__shader, "u_flow_map");

	ScreenFXEffectVarsEnsure(
		"speed", .07,
		"frames", 11,
		"strength", .05,
		"sprite", __spr_screenFX_noise2,
		"surface", undefined,
		"image_index", undefined,
		"timescale", 1
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		var _texture = surface_exists(vars.surface) ? surface_get_texture(vars.surface) : 
							sprite_get_texture(vars.sprite, vars.image_index ?? _time);
		var _timeValue = vars.timescale * _time;
		shader_set_uniform_f(_uTime, (60+_time) / 10);
		shader_set_uniform_i(_uFrames, ceil((_timeValue % vars.frames))+1);
		shader_set_uniform_f(_uSpeed, vars.speed);
		shader_set_uniform_f(_uStrength, vars.strength);
		texture_set_stage(_uFlowMap, _texture);
		gpu_set_tex_repeat_ext(_uFlowMap, true);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}