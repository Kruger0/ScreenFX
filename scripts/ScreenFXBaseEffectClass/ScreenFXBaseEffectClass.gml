// feather ignore all
/// @param {Struct} vars
function ScreenFXBaseEffectClass(_vars = undefined) constructor {
	static __name = "ScreenFXBase";
	static __priority = -1;
	static __DirtyCallback = function() {};
	static __CleanupCallback = function() {};
	static __SerializeVars = function() {return GetVars()};
	static __shader = __shd_screenFX_passthrough;
	static __Serialise = function() {
		return {
			vars: __SerailiseVars(),
			className: instanceof(self),
		};
	};

	__dirty = true;
	__enabled = true;	

	vars = {};

	if (is_struct(_vars)) {
		struct_foreach(_vars, function(_name, _value) {
			vars[$ _name] = _value;
		});
	}

	/// @return {Struct}
	static GetVars = function() {
		return variable_clone(vars);
	};

	/// @param {String} name
	/// @param {Any} value
	static SetVar = function(_name, _value) {
		vars[$ _name] = _value;
		__dirty = true;
		return self;
	};

	/// @param {String} name
	/// @param {Any} value
	/// @param {Any} ...
	static SetVars = function(_name, _value) {
		var _i = 0;
		repeat(argument_count div 2) {
			vars[$ argument[_i]] = argument[_i+1];
			_i += 2;
		}
		__dirty = true;
		return self;
	};

	/// @param {String} name
	static GetVar = function(_name) {
		return vars[$ _name];
	};

	/// @param {Bool} renderState
	static SetRenderState = function(_value) {
		__enabled = _value;
		return self;
	};

	/// @return {Bool}
	static GetRenderState = function() {
		return __enabled;
	};


	/// @return {String}
	static GetName = function() {
		return __name;
	};

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}