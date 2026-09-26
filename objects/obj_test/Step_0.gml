if (keyboard_check_released(vk_space)) {
	renderer.SetProfile(profile);
}

if (keyboard_check_released(vk_control)) {
	renderer.SetRenderEffects(!renderer.GetRenderEffects())
}

var _hspd = keyboard_check(vk_right) - keyboard_check(vk_left);
var _vspd = keyboard_check(vk_down) - keyboard_check(vk_up);

_vspd *= 6;
_hspd *= 6;

var _x = camera_get_view_x(view_camera[0])+_hspd;
var _y = camera_get_view_y(view_camera[0])+_vspd;
camera_set_view_pos(view_camera[0], _x, _y);