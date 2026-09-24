var x1 = bbox_left;
var y1 = bbox_top;
var x2 = bbox_right;
var y2 = bbox_bottom;

var w = x2 - x1;
var h = y2 - y1;

if (!surface_exists(surface)) surface = surface_create(ceil(w), ceil(h));


var _finalX = x - w / 2;
var _finalY = y - h / 2;


surface_set_target(surface);
draw_surface_general(application_surface, _finalX, _finalY, sprite_width, sprite_height, 0, 0, 1, 1, 0, c_white, c_white, c_white, c_white, 1);
surface_reset_target();

renderer.DrawExt(surface, _finalX, _finalY, 1, 1, 0, c_white, 1);

if (debug) {
	draw_self();
	//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
}