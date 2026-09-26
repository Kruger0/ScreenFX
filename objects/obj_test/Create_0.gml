application_surface_draw_enable(false);

renderer = new ScreenFXRenderer();

profile = new ScreenFXProfile("Test", [
	new ScreenFXEffectChromaticAberration({
		xoffset: 0.03,
		yoffset: 0.03,
	}),
	new ScreenFXEffectWobble({
		timescale: .01,
	}),
	new ScreenFXEffectBlendTexture(),
]);

view_enabled = true;
view_visible[0] = true;

show_debug_overlay(true, true);

call_later(1, time_source_units_frames, function() {
	with(obj_screenfx_region) {
		debug = true;
	}
});