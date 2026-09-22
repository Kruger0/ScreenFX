if (!surface_exists(surface)) surface = surface_create(sprite_width, sprite_height);


var _finalX = x - surface_get_width(surface) / 2;
var _finalY = y - surface_get_height(surface) / 2;


surface_set_target(surface);
draw_clear_alpha(c_black, 0);
draw_surface_part_ext(application_surface, _finalX, _finalY, sprite_width, sprite_height, 0, 0, 1, 1, c_white, 1);
surface_reset_target();

renderer.DrawExt(surface, _finalX, _finalY, 1, 1, image_angle, c_white, 1);

if (debug) {
	draw_self();
}