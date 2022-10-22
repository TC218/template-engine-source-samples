package rflib.common.base;

extern abstract BitFields<T>(Int) {
	@:pure(inferredPure) @:noCompletion function _new(i : Null<Int> = 0) : BitFields<T>;
	@:pure(inferredPure) function get(this : Int, bits : T) : BitFields<T>;
	@:pure(inferredPure) function set(this : Int, bits : T) : BitFields<T>;
	@:pure(inferredPure) function clear(this : Int, bits : T) : BitFields<T>;
	@:pure(inferredPure) function keep(this : Int, bits : T) : BitFields<T>;
	@:pure(inferredPure) function has(this : Int, bits : T) : Bool;
	@:pure(inferredPure) function hasAll(this : Int, bits : T) : Bool;
}
