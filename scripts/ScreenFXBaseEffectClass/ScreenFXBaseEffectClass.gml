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

	static GetVars = function() {
		return variable_clone(vars);
	};

	static SetVar = function(_name, _value) {
		vars[$ _name] = _value;
		__dirty = true;
	};

	static GetVar = function(_name) {
		return vars[$ _name];
	};

	static SetRenderState = function(_value) {
		__enabled = _value;
		return self;
	};

	static GetRenderState = function() {
		return __enabled;
	};


	static GetName = function() {
		return __name;
	};

	static __Apply = function(_surf, _time) {
		shader_set(__shader);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}