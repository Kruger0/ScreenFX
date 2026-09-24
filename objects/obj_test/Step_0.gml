if (keyboard_check_released(vk_space)) {
	//renderer.AddEffect(ScreenFXVignetteEffectClass);
	renderer.AddEffect(ScreenFXPixelateEffectClass);
	//renderer.AddEffect(new ScreenFXSaturationEffectClass({
	//	saturation: 0.25,
	//}));
}

if (keyboard_check_released(vk_control)) {
	renderer.SetRenderEffects(!renderer.GetRenderEffects())
}