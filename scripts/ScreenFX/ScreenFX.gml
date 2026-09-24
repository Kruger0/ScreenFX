function ScreenFX() constructor {
	__effects = [];
	__dirtySort = false;
	__pingPongA = handle_parse("ref surface -1");
	__pingPongB = handle_parse("ref surface -1");
	__autoSort = true;
	__renderEffects = true;
	__formatOverride = undefined;

	static SetAutoSort = function(_value) {
		if (!is_bool(_value)) throw "bad!";
		__autoSort = _value;
		return self;
	};

	static GetAutoSort = function() {
		return __autoSort;
	};

	static SetOverrideFormat = function(_value) {
		__formatOverride = _value;
		return self;
	};

	static GetOverrideFormat = function() {
		return __formatOverride;
	};

	static SetRenderEffects = function(_value) {
		if (!is_bool(_value)) throw "bad!";
		__renderEffects = _value;
		return self;
	};

	static GetRenderEffects = function() {
		return __renderEffects;
	};

	static Destroy = function() {
		if (surface_exists(__pingPongA)) surface_free(__pingPongA);
		if (surface_exists(__pingPongB)) surface_free(__pingPongB);
		array_foreach(__effects, function(_elm) {
			_elm.__cleanupCallback();
		});

		array_resize(__effects, 0);
	};

	static AddEffect = function(_effectClass) {
		var _effect = is_callable(_effectClass) ? new _effectClass() : _effectClass;
		array_push(__effects, _effect);
		__dirtySort = true;
		return _effect;
	};

	static RemoveEffect = function(_index) {
		var _effect = __effects[_index];
		_effect.__cleanupCallback();
		array_delete(__effects, _index, 1);
		__dirtySort = true;
	};

	static ClearEffects = function() {
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

	static FilterEffects = function(_callback) {
		return array_filter(__effects, _callback);
	};

	static DrawSurface = function(_surf, _x, _y) {
		draw_surface(__RenderEffects(_surf), _x, _y);
	};

	static DrawExt = function(_surf, _x, _y, _xscale, _yscale, _angle, _blend, _alpha) {
		draw_surface_ext(__RenderEffects(_surf), _x, _y, _xscale, _yscale, _angle, _blend, _alpha);
	};
	
	static DrawSurfaceStretched = function(_surf, _x, _y, _w, _h) {
		draw_surface_stretched(__RenderEffects(_surf), _x, _y, _w, _h);
	};

	static DrawGeneral = function(_surface, _left, _top, _width, _height, _x, _y, _xscale, _yscale, _angle, _blend, _blend2, _blend3, _blend4, _alpha) {
		draw_surface_general(__RenderEffects(_surface), _left, _top, _width, _height, _x, _y, _xscale, _yscale, _angle, _blend, _blend2, _blend3, _blend4, _alpha);
	};

	static DrawPart = function(_surf, _left, _top, _width, _height, _x, _y) {
		draw_surface_part(__RenderEffects(_surf), _left, _top, _width, _height, _x, _y);
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

		if (__renderEffects) {
			for(var _i = 0, _len = array_length(__effects); _i < _len; ++_i) {
				var _effect = __effects[_i];
				if (_effect.__dirty) {
					_effect.__dirtyCallback();
					_effect.__dirty = false;
				}
        	
				surface_set_target(_targetSurfA); 
				_effect.Apply(_targetSurfB);
				surface_reset_target();
				_targetSurfC = _targetSurfA;
				_targetSurfA = _targetSurfB;
				_targetSurfB = _targetSurfC;
			}
		}

		return _targetSurfB;
	};
}