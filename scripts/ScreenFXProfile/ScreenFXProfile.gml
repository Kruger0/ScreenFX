function ScreenFXProfile(_name, _effects = []) constructor {
	static __name = _name;
	__effects = array_map(_effects, function(_elm) {
		return is_callable(_elm) ? new _elm() : _elm;
	});

	static GetName = function() {
		return __name;
	};

	static Export = function() {
		return {
			vars: array_map(__effects, function(_effect) {
				return _effect.__Serialise();
			}),
			name: __name,
		};
	};
}