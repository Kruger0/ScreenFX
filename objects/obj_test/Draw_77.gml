var _pos = application_get_position();
var _xx = _pos[0];
var _yy = _pos[1];
var _ww = _pos[2] - _pos[0];
var _hh = _pos[3] - _pos[1];

//draw_surface_stretched(application_surface, _xx, _yy, _ww, _hh);
renderer.DrawSurfaceStretched(application_surface, _xx, _yy, _ww, _hh);