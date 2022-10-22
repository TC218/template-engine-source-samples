package rflib.common.utils;

@:generic extern class ContextsStack<T> {
	var current(get,never) : T;
	var has_items(get,never) : Bool;
	var stack : Array<T>;
	@:pure(inferredPure) function new() : Void;
	function enter(item : T, cb : () -> Void) : Void;
	@:pure(inferredPure) function get_current() : T;
	@:pure(inferredPure) function get_has_items() : Bool;
}
