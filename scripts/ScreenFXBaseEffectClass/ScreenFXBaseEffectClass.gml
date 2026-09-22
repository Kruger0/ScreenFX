function ScreenFXBaseEffectClass(_vars = undefined) constructor {
	static __name = "ScreenFXBase";
	static __priority = -1;
	static __dirtyCallback = function() {};
	static __cleanupCallback = function() {};
	static __shader = __shd_screenFX_example;

	__dirty = true;
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

	static Apply = function(_surf) {
		shader_set(__shader);
		draw_surface(_surf, 0, 0);
		shader_reset();
	};
}

function ScreenFXEffectVarsEnsure() {
	for(var _i = 0; _i < argument_count; _i +=2) {
		vars[$ argument[_i]] ??= argument[_i+1];
	}
}