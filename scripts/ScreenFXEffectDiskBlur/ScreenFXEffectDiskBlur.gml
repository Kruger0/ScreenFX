// feather ignore all
/// @param {Struct} vars
function ScreenFXEffectDiskBlur(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Disk Blur";
	static __priority = 12;
	static __shader = __shd_screenFX_disk_blur;
	static _uSampleCount = shader_get_uniform(__shader, "u_sample_count");
	static _uBlurRadius = shader_get_uniform(__shader, "u_blur_radius");
	static _uTextureSize = shader_get_uniform(__shader, "u_texture_size");

	ScreenFXEffectVarsEnsure(
		"blur_radius", 3,
		"sample_count", 16,
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uTextureSize, surface_get_width(_surf), surface_get_height(_surf));
		shader_set_uniform_f(_uBlurRadius, vars.blur_radius);
		shader_set_uniform_f(_uSampleCount, vars.sample_count);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}