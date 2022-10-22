package rflib.common.hscript;

extern class HScriptDataFile<T> {
	var autosaveMs : Int;
	var autosaveTimer : rflib.common.Timer;
	var changed : Bool;
	var constrainClass : Class<T>;
	var data : T;
	var path : rflib.common.Str;
	@:pure(inferredPure) function new(path : rflib.common.Str, ?constrainClass : Class<T>) : Void;
	function enableAutosave(ms : Int = 0) : Void;
	function load(getDefaultCb : () -> T) : HScriptDataFile<T>;
	function save() : Void;
}
