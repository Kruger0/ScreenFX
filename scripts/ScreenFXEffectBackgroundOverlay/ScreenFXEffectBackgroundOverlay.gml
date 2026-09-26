/// @param {Struct} vars
function ScreenFXEffectBackgroundOverlay(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static _name = "Background Overlay";
	static __priority = -1;
	static __shader = __shd_screenFX_background_overlay;
	static _uMaxBrightness = shader_get_uniform(__shader, "u_max_brightness");
	static _uIntensity = shader_get_uniform(__shader, "u_intensity");
	static _uPos = shader_get_uniform(__shader, "u_pos");
	static _uOffset = shader_get_uniform(__shader, "u_offset");
	static _uScale = shader_get_uniform(__shader, "u_scale");
	static _uTexReplacement = shader_get_sampler_index(__shader, "u_tex_replacement");

	ScreenFXEffectVarsEnsure(
		"minFade", 0.5,
		"intensity", 2,
		"sprite", __spr_screenFX_stars_background,
		"surface", undefined,
		"image_index", undefined,
		"xspeed", 1,
		"yspeed", 1,
		"xoffset", 0,
		"yoffset", 0,
		"timescale", 1,
		"xscale", 1,
		"yscale", 1,
	);

	static __Apply = function(_surf, _time) {
		var _texture = is_handle(vars.surface) ? surface_get_texture(vars.surface) : sprite_get_texture(vars.sprite, vars.image_index ?? _time);
		shader_set(__shader);
		shader_set_uniform_f(_uMaxBrightness, vars.minFade);
		shader_set_uniform_f(_uIntensity, vars.intensity);
		texture_set_stage(_uTexReplacement, _texture);
		gpu_set_tex_repeat_ext(_uTexReplacement, true);
		gpu_set_tex_filter_ext(_uTexReplacement, false);

		var _timeValue = (_time * vars.timescale);
		var _xpos = texture_get_texel_width(_texture) * (vars.xspeed * _timeValue);
		var _ypos = texture_get_texel_height(_texture) * (vars.yspeed * _timeValue);
		shader_set_uniform_f(_uPos, _xpos, _ypos);
		shader_set_uniform_f(_uScale, vars.xscale, vars.yscale);
		shader_set_uniform_f(_uOffset, vars.xoffset, vars.yoffset);

		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}