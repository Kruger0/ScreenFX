// feather ignore all
function ScreenFXRenderer() constructor {
	__effects = [];
	__dirtySort = false;
	__pingPongA = handle_parse("ref surface -1");
	__pingPongB = handle_parse("ref surface -1");
	__layerSurface = handle_parse("ref surface -1");
	__autoSort = true;
	__renderEffects = true;
	__formatOverride = undefined;
	__renderStack = handle_parse("ref surface -1");
	__profile = undefined;
	__layerIds = [];
	__timeCallback = function() {return current_time / 10;};
	
	__frame = 0;


	/// @param {String, Id.Layer} layer
	static AddLayers = function() {
		var _i = 0;
		repeat(argument_count) {
			var _layer = argument[_i++];
			var _layerId = is_string(_layer) ? layer_get_id(_layer) : _layer;
			if (array_get_index(__layerIds, _layerId) != -1) return self;
			
			array_push(__layerIds, _layerId);		
        	
			layer_script_begin(_layerId, function() {
				if (event_type == ev_draw) && (event_number == ev_draw_normal) {
					var _camera = view_camera[view_current];
					var _cameraWidth = camera_get_view_width(_camera);
					var _cameraHeight = camera_get_view_height(_camera);
        	
					if (!surface_exists(__layerSurface)) __layerSurface = surface_create(_cameraWidth, _cameraHeight);
					surface_set_target(__layerSurface);
					draw_clear_alpha(0, 0);
				}
			});
        	
			layer_script_end(_layerId, function() {
				if (event_type == ev_draw) && (event_number == ev_draw_normal) {
					var _camera = view_camera[view_current];
					surface_reset_target();
					DrawSurface(__layerSurface, camera_get_view_x(_camera), camera_get_view_y(_camera));
				}
			});
		}

		return self;
	};

	/// @param {String, Id.Layer} layer
	static RemoveLayer = function(_layer) {
		var _layerId = is_string(_layer) ? layer_get_id(_layer) : _layer;
		var _index = array_get_index(__layerIds, _layerId);
		if (_index != -1) {
			layer_script_begin(_layerId, -1);
			layer_script_end(_layerId, -1);
			array_delete(__layerIds, _index, 1);
		}
	}

	/// @return {Array<Id.Layer>}
	static GetLayers = function() {
		return variable_clone(__layerIds);
	};
	
	static ClearLayers = function() {
		array_foreach(__layerIds, function(_elm) {
			layer_script_begin(_elm, -1);
			layer_script_end(_elm, -1);
		});
		array_resize(__layerIds, 0);
	};


	/// @param {Struct.ScreenFXProfile} profile
	static SetProfile = function(_profile) {
		__profile = _profile;
		ClearEffects();
		if (is_struct(_profile)) method_call(AddEffectExt, __profile.__effects);
		return self;
	};

	static ClearProfile = function() {
		__profile = undefined;
		ClearEffects();
	};

	/// @return {Struct.ScreenFXProfile}
	static GetProfile = function() {
		return __profile;
	};

	static GetProfileName = function() {
		if (is_struct(__profile)) return __profile.GetName();
		return "";
	};

	/// @param {Bool} autoSort
	static SetAutoSort = function(_value) {
		if (!is_bool(_value)) __ScreenFXError($"SetAutoSort() Must be a bool! Got \"{_value}\".");
		__autoSort = _value;
		return self;
	};

	static GetAutoSort = function() {
		return __autoSort;
	};

	/// @param {Constant.SurfaceFormatType} surfaceFormat
	static SetOverrideFormat = function(_value) {
		__formatOverride = _value;
		return self;
	};

	static GetOverrideFormat = function() {
		return __formatOverride;
	};

	/// @param {Bool} renderEffects
	static SetRenderEffects = function(_value) {
		if (!is_bool(_value)) __ScreenFXError($"SetRenderEffects() Must be a bool! Got \"{_value}\".");
		__renderEffects = bool(_value);
		return self;
	};

	static GetRenderEffects = function() {
		return __renderEffects;
	};

	static Destroy = function() {
		if (surface_exists(__pingPongA)) surface_free(__pingPongA);
		if (surface_exists(__pingPongB)) surface_free(__pingPongB);
		ClearLayers();
		ClearProfile();
	};

	/// @param {Struct.ScreenFXBaseEffectClass} effect
	static AddEffect = function(_effectClass) {
		var _effect = is_callable(_effectClass) ? new _effectClass() : _effectClass;
		array_push(__effects, _effect);
		__dirtySort = true;
		return _effect;
	};

	/// @param {Struct.ScreenFXBaseEffectClass} effect
	static AddEffectExt = function() {
		var _i = 0;
		repeat(argument_count) {
			var _effectClass = argument[_i++];
			var _effect = is_callable(_effectClass) ? new _effectClass() : _effectClass;
			array_push(__effects, _effect);
			__dirtySort = true;
		}
	};

	/// @param {Struct.ScreenFXBaseEffectClass} effect
	static SetEffects = function() {
		ClearProfile();
		var _i = 0;
		repeat(argument_count) {
			var _effectClass = argument[_i++];
			var _effect = is_callable(_effectClass) ? new _effectClass() : _effectClass;
			array_push(__effects, _effect);
			__dirtySort = true;
		}
	};

	static RemoveEffect = function(_index) {
		var _effect = __effects[_index];
		_effect.__CleanupCallback();
		array_delete(__effects, _index, 1);
		__dirtySort = true;
	};

	static ClearEffects = function() {
		array_foreach(__effects, function(_elm) {
			_elm.__CleanupCallback();
		});
		array_resize(__effects, 0);
	};

	static FindEffectByName = function(_name) {
		var _index;
		with({_name}) _index = array_find_index(__effects, function(_elm, _index) {
			return _elm.__name = _name;
		});

		if (_index == -1) return undefined;
		return __effects[_i];
	}; 

	static FindEffectIndex = function(_effect) {
		return array_get_index(__effects, _effect);
	};

	static GetEffect = function(_index) {
		if (_index < 0) return undefined;
		if (_index >= array_length(__effects)) return undefined;

		return __effects[_index];
	};

	/// @return {Array<Struct.ScreenFXBaseEffectClass>}
	static GetEffects = function() {
		return variable_clone(__effects, 1);
	};

	static SetEffectsOrder = function(_effects) {
		if (!array_equals(__effects, _effects)) {
			__ScreenFXError("The provided effects do not match what is within the renderer");
		}

		var _i = 0;
		repeat(array_length(_effects)) {
			__effects[_i] = _effects[_i];
			++_i;	
		}

		return self;
	};

	static GetRenderOutput = function() {
		return __renderStack;
	};

	/// @param {Function} class
	static FindEffectByClass = function(_class) {
		var _index;
		with({_class}) _index = array_find_index(__effects, function(_elm, _index) {
			return is_instanceof(_elm, _class);
		});

		if (_index == -1) return undefined;
		return __effects[_i];
	};

	static SortEffects = function() {
		static _callback = function(_a, _b) {
			return sign(_a.__priority - _b.__priority);
		};

		array_sort(__effects, _callback);
	};

	/// @param {Function} callback
	static FilterEffects = function(_callback) {
		return array_filter(__effects, _callback);
	};

	/// @param {Id.Surface} surface
	/// @param {Real} x
	/// @param {Real} y
	static Draw = function(_surf, _x, _y) {
		draw_surface(__RenderEffects(_surf), _x, _y);
	};

	/// @param {Id.Surface} surface
	/// @param {Real} x
	/// @param {Real} y
	/// @param {Real} xscale
	/// @param {Real} yscale
	/// @param {Real} angle
	/// @param {Real, Constant.Colour} blend
	/// @param {Real} alpha
	static DrawExt = function(_surf, _x, _y, _xscale, _yscale, _angle, _blend, _alpha) {
		draw_surface_ext(__RenderEffects(_surf), _x, _y, _xscale, _yscale, _angle, _blend, _alpha);
	};
	
	/// @param {Id.Surface} surface
	/// @param {Real} x
	/// @param {Real} y
	/// @param {Real} width
	/// @param {Real} height
	static DrawStretched = function(_surf, _x, _y, _w, _h) {
		draw_surface_stretched(__RenderEffects(_surf), _x, _y, _w, _h);
	};

	/// @param {Id.Surface} surface
	/// @param {Real} left
	/// @param {Real} top
	/// @param {Real} width
	/// @param {Real} height
	/// @param {Real} x
	/// @param {Real} y
	/// @param {Real} xscale
	/// @param {Real} yscale
	/// @param {Real} angle
	/// @param {Real, Constant.Colour} blend1
	/// @param {Real, Constant.Colour} blend2
	/// @param {Real, Constant.Colour} blend3
	/// @param {Real, Constant.Colour} blend4
	/// @param {Real} alpha
	static DrawGeneral = function(_surface, _left, _top, _width, _height, _x, _y, _xscale, _yscale, _angle, _blend, _blend2, _blend3, _blend4, _alpha) {
		draw_surface_general(__RenderEffects(_surface), _left, _top, _width, _height, _x, _y, _xscale, _yscale, _angle, _blend, _blend2, _blend3, _blend4, _alpha);
	};

	/// @param {Id.Surface} surface
	/// @param {Real} left
	/// @param {Real} top
	/// @param {Real} width
	/// @param {Real} height
	/// @param {Real} x
	/// @param {Real} y
	static DrawPart = function(_surf, _left, _top, _width, _height, _x, _y) {
		draw_surface_part(__RenderEffects(_surf), _left, _top, _width, _height, _x, _y);
	};

	static DrawApplicationSurface = function() {
		static _usesGXCanvas = extension_exists("GXCanvas");
		
		if (!application_surface_is_enabled()) {
			__ScreenFXError("Cannot use .DrawApplicationSurface() as there is no application surface available!");
		}

		if (event_type == ev_draw) {
			switch(event_number) {
				case ev_draw_post:
					if (os_type == os_gxgames) {
						if (_usesGXCanvas) {
							DrawStretched(application_surface, 0, 0, GXCanvasGetCanvasWidth(), GXCanvasGetCanvasHeight());
							return;
						}
					}
					var _pos = application_get_position();
					var _xx = _pos[0];
					var _yy = _pos[1];
					var _ww = _pos[2] - _pos[0];
					var _hh = _pos[3] - _pos[1];
					
					DrawStretched(application_surface, _xx, _yy, _ww, _hh);
				break;

				case ev_gui: case ev_gui_begin: case ev_gui_end:
					DrawStretched(application_surface, 0, 0, display_get_gui_width(), display_get_gui_height());
				break;
			}
		} 
	};

	static Render = function(_surface) {
		return __RenderEffects(_surface);
	};

	static __RegenPingPong = function(_width, _height, _format) {
		if (!surface_exists(__pingPongA)) {
			__pingPongA = surface_create(_width, _height);
		}

		if (!surface_exists(__pingPongB)) {
			__pingPongB = surface_create(_width, _height);
		}

		if (surface_get_format(__pingPongA) != _format) {
			surface_free(__pingPongA);
			__pingPongA = surface_create(_width, _height, _format);
		}

		if (surface_get_format(__pingPongB) != _format) {
			surface_free(__pingPongB);
			__pingPongB = surface_create(_width, _height, _format);
		}

		if (surface_get_width(__pingPongA) != _width || surface_get_height(__pingPongA) != _height) {
			surface_resize(__pingPongA, _width, _height);
		}

		if (surface_get_width(__pingPongB) != _width || surface_get_height(__pingPongB) != _height) {
			surface_resize(__pingPongB, _width, _height);
		}


		surface_set_target(__pingPongA);
		surface_set_target(__pingPongB);
		draw_clear_alpha(0, 0);
		surface_reset_target();
		draw_clear_alpha(0, 0);
		surface_reset_target();
	};

	static __PrepareEffects = function() {
		if (__dirtySort) && (array_length(__effects) >= 2) {
			if (__autoSort) SortEffects();
			__dirtySort = false;
		}
	};

	static __RenderEffects = function(_surf) {
		__RegenPingPong(surface_get_width(_surf), surface_get_height(_surf), __formatOverride ?? surface_get_format(_surf));
		__PrepareEffects();
		surface_copy(__pingPongA, 0, 0, _surf);

		var _targetSurfA = __pingPongB;
		var _targetSurfB = __pingPongA;
		var _targetSurfC;

		__frame += 1 * (delta_time / game_get_speed(gamespeed_microseconds));

		gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha);
		if (__renderEffects) {
			for(var _i = 0, _len = array_length(__effects); _i < _len; ++_i) {
				var _effect = __effects[_i];
				if (_effect.__enabled) {
					if (_effect.__dirty) {
						_effect.__DirtyCallback();
						_effect.__dirty = false;
					}
        	    	
					surface_set_target(_targetSurfA); 
					_effect.__Apply(_targetSurfB, __frame);
					surface_reset_target();
					_targetSurfC = _targetSurfA;
					_targetSurfA = _targetSurfB;
					_targetSurfB = _targetSurfC;
				}
			}
		}
		gpu_set_blendmode(bm_normal);

		__renderStack = _targetSurfB;
		return _targetSurfB;
	};
}