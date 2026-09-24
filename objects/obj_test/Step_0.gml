if (keyboard_check_released(vk_space)) {
	renderer.SetProfile(profile);
}

if (keyboard_check_released(vk_control)) {
	renderer.SetRenderEffects(!renderer.GetRenderEffects())
}