// feather ignore all
/// @param {String} name
/// @param {Any} value
/// @param {Any} ...
function ScreenFXEffectVarsEnsure(_name, _value) {
	for(var _i = 0; _i < argument_count; _i +=2) {
		vars[$ argument[_i]] ??= argument[_i+1];
	}
}