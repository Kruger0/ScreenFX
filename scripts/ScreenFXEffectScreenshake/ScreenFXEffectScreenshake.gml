// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectScreenshake(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Screenshake";
	static __priority = 9_999_999;
	static __shader = __shd_screenFX_screenshake;
	static _uMagnitude = shader_get_uniform(__shader, "u_magnitude");
	static _uShakeSpeed = shader_get_uniform(__shader, "u_shake_speed");
	static _uNoiseTexture = shader_get_sampler_index(__shader, "u_noise_texture");
	//static _uTime = shader_get_uniform(__shader, "u_time");
	static _uSurfaceResolution = shader_get_uniform(__shader, "u_surface_resolution");
	static _uNoiseResolution = shader_get_uniform(__shader, "u_noise_resolution");

	ScreenFXEffectVarsEnsure(
		"shake_speed", 0.25,
		"magnitude", 4,
		"timescale", 1,
		"sprite", __spr_screenFX_noise,
		"surface", undefined,
		"image_index", undefined,
	);

	static __Apply = function(_surf, _time) {
		var _texture = surface_exists(vars.surface) ? surface_get_texture(vars.surface) : sprite_get_texture(vars.sprite, vars.image_index ?? _time);
		var _timeValue = (_time * vars.timescale);
		var _width = surface_exists(vars.surface) ? surface_get_width(vars.surface) : sprite_get_width(vars.sprite);		
		var _height = surface_exists(vars.surface) ? surface_get_height(vars.surface) : sprite_get_height(vars.sprite);

		shader_set(__shader);

		shader_set_uniform_f(_uMagnitude, vars.magnitude);
		shader_set_uniform_f(_uShakeSpeed, vars.shake_speed + _timeValue);
		shader_set_uniform_f(_uNoiseResolution, _width, _height);
		shader_set_uniform_f(_uSurfaceResolution, surface_get_width(_surf), surface_get_height(_surf));

		texture_set_stage(_uNoiseTexture, _texture);
		gpu_set_tex_filter_ext(_uNoiseTexture, true);
		gpu_set_tex_repeat_ext(_uNoiseTexture, true);

		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}