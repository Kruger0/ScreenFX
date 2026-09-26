/// @param {Struct} vars
function ScreenFXEffectBlendTexture(_vars = undefined) : ScreenFXBaseEffectClass(_vars) constructor {
	static __name = "Blend Texture";
	static __priority = -10;
	static __shader = __shd_screenFX_blend_texture;
	static _uOpacity = shader_get_uniform(__shader, "u_opacity");
	static _uMix = shader_get_uniform(__shader, "u_mix");
	static _uDiffuse = shader_get_sampler_index(__shader, "u_diffuse");

	ScreenFXEffectVarsEnsure(
		"alpha", 1,
		"sprite", __spr_screenFX_overlay,
		"surface", undefined,
		"mix", 1,
		"image_index", undefined,
		"filtered", false
	);

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		shader_set_uniform_f(_uOpacity, vars.alpha);
		shader_set_uniform_f(_uMix, vars.mix);
		var _texture = surface_exists(vars.surface) ? surface_get_texture(vars.surface) : sprite_get_texture(vars.sprite, vars.image_index ?? _time);
		texture_set_stage(_uDiffuse, _texture);
		gpu_set_tex_filter_ext(_uDiffuse, vars.filtered);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}