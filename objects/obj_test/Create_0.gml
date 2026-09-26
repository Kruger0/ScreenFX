application_surface_draw_enable(false);

renderer = new ScreenFXRenderer();

profile = new ScreenFXProfile("Test", [
	new ScreenFXEffectPixelate()
]);

view_enabled = true;
view_visible[0] = true;