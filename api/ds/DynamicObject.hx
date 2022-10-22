package rflib.common.ds;

extern abstract DynamicObject<T>(Dynamic<T>) {
	@:pure(inferredPure) @:noCompletion function _new() : DynamicObject<T>;
	@:has_untyped @:arrayAccess function set(this : Dynamic<T>, key : String, value : T) : T;
	@:pure(inferredPure) @:has_untyped @:arrayAccess function get(this : Dynamic<T>, key : String) : Null<T>;
	@:pure(inferredPure) function exists(this : Dynamic<T>, key : String) : Bool;
	function remove(this : Dynamic<T>, key : String) : Bool;
	function keys(this : Dynamic<T>) : Array<String>;
	function iterator(this : Dynamic<T>) : Iterator<T>;
}
