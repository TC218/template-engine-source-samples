package rflib.common.sys;

@:keep extern class FSObjectsList {
	@:keep var dir : rflib.common.Str;
	@:pure(inferredPure) @:keep function new(d : rflib.common.Str) : Void;
	@:keep function iterator() : Iterator<rflib.common.Str>;
}
