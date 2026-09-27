var _w = ceil(abs(bbox_right - bbox_left));
var _h = ceil(abs(bbox_bottom - bbox_top));

_w = max(_w, 1);
_h = max(_h, 1);


var _finalX = x - _w / 2;
var _finalY = y - _h / 2;


if (autoExitEarly) && (!sphere_is_visible(_finalX, _finalY, depth, max(_w, _h))) exit;

if (!surface_exists(surface)) {
	surface = surface_create(_w, _h);
}

if (imageAngleDirty != image_angle) {
	imageAngleDirty = image_angle;
	surface_resize(surface, _w, _h);
}

if (imageXScaleDirty != image_xscale) {
	imageXScaleDirty = image_xscale;
	surface_resize(surface, _w, _h);
}

if (imageYScaleDirty != image_yscale) {
	imageYScaleDirty = image_yscale;
	surface_resize(surface, _w, _h);
}

surface_set_target(surface);
	draw_clear_alpha(c_black, 0);
	
	draw_clear_stencil(0);
	
	gpu_set_stencil_enable(true);
	gpu_set_stencil_write_mask(1);
	gpu_set_stencil_func(cmpfunc_always);
	gpu_set_stencil_pass(stencilop_replace);
	
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(127);
	gpu_set_colorwriteenable(false, false, false, false);
	draw_sprite_ext(regionMask, 0, _w div 2, _h div 2, image_xscale, image_yscale, image_angle, c_white, 1);
	gpu_set_colorwriteenable(true, true, true, true);
	gpu_set_alphatestenable(false);
	
	gpu_set_stencil_ref(1);
	gpu_set_stencil_read_mask(1);
	gpu_set_stencil_pass(stencilop_keep);
	gpu_set_stencil_func(cmpfunc_equal);

	var _cam = view_camera[view_current];
	
	var _camX = camera_get_view_x(_cam);
	var _camY = camera_get_view_y(_cam);
	var _viewW = camera_get_view_width(_cam);
	var _viewH = camera_get_view_height(_cam);
	
	var _appW = surface_get_width(application_surface);
	var _appH = surface_get_height(application_surface);
	
	var _scaleX = _appW / _viewW;
	var _scaleY = _appH / _viewH;
	
	var _srcX = (_finalX - _camX) * _scaleX;
	var _srcY = (_finalY - _camY) * _scaleY;
	
	var _srcW = _w * _scaleX;
	var _srcH = _h * _scaleY;
	
	draw_surface_part_ext(
	    application_surface,
	    _srcX,
	    _srcY,
	    _srcW,
	    _srcH,
	    0,
	    0,
	    _w / _srcW,
	    _h / _srcH,
	    c_white,
	    1
	);

	gpu_set_stencil_enable(false);
surface_reset_target();

renderer.Draw(surface, _finalX, _finalY);

if (debug) {
	if (debugRegion) draw_self();
	if (debugBounds) draw_rectangle_colour(bbox_left, bbox_top, bbox_right, bbox_bottom, c_white, c_white, c_white, c_white, true);
	if (debugEffectNames) {
		var _names = array_map(renderer.GetEffects(), function(_effect) {
			return _effect.GetName();
		});
		
		_names = string_join_ext("\n", _names);

		draw_set_alpha(0.8);
		draw_rectangle_colour(bbox_left+4, bbox_top, bbox_left+4 + string_width(_names)+8, bbox_top+string_height(_names)+4, c_black, c_black, c_black, c_black, false);
		draw_set_colour(c_white);
		draw_text(bbox_left + 8, bbox_top, _names);
		draw_set_alpha(1);
	}
}