/// @param {String} name
/// @param {Any} value
function ScreenFXEffectVarsEnsure() {
	for(var _i = 0; _i < argument_count; _i +=2) {
		vars[$ argument[_i]] ??= argument[_i+1];
	}
}