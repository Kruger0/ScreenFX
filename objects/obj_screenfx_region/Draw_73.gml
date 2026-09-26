var _w = ceil(abs(bbox_right - bbox_left));
var _h = ceil(abs(bbox_bottom - bbox_top));

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


var _finalX = x - _w / 2;
var _finalY = y - _h / 2;


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

	var _x = camera_get_view_x(view_camera[view_current]);	
	var _y = camera_get_view_y(view_camera[view_current]);

	draw_surface_general(application_surface, _finalX -_x, _finalY- _y, _w, _h, 0, 0, 1, 1, 0, c_white, c_white, c_white, c_white, 1);
	gpu_set_stencil_enable(false);
surface_reset_target();

renderer.Draw(surface, _finalX, _finalY);

if (debug) {
	draw_self();
	if (debugBounds) draw_rectangle_colour(bbox_left, bbox_top, bbox_right, bbox_bottom, c_white, c_white, c_white, c_white, true);
}