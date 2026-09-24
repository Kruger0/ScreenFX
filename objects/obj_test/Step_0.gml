if (keyboard_check_released(vk_space)) {
	//renderer.AddEffect(ScreenFXVignetteEffect);
	renderer.AddEffect(ScreenFXPixelateEffect);
	//renderer.AddEffect(new ScreenFXSaturationEffect({
	//	saturation: 0.25,
	//}));
}

if (keyboard_check_released(vk_control)) {
	renderer.SetRenderEffects(!renderer.GetRenderEffects())
}