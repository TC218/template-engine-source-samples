package rflib.common.utils;

extern class StringsRegistry {
	private var strings : Array<String>;
	private var strings_map : Map<String,rflib.common.Id>;
	@:pure(inferredPure) function new() : Void;
	@:pure(inferredPure) function getIndex(s : String) : Null<rflib.common.Id>;
	@:pure(inferredPure) function getString(id : rflib.common.Id) : String;
	function index(s : String) : rflib.common.Id;
}
