function ScreenFXProfile(_name, _effects = []) constructor {
	__name = _name;
	__effects = array_map(_effects, function(_elm) {
		return is_callable(_elm) ? new _elm() : _elm;
	});

	static GetName = function() {
		return __name;
	};
}