package rflib.common.sys;

@:keep extern class FSObjectsIterator {
	@:keep private var files : rflib.common.Arr<rflib.common.Str>;
	@:keep private var i : Int;
	@:keep function new(dir : rflib.common.Str) : Void;
	@:keep function hasNext() : Bool;
	@:keep function next() : rflib.common.Str;
}
