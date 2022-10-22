package rflib.common.utils;

extern class SingletonsRegistry {
	static var cached_instances : Map<Class<Dynamic>,Dynamic>;
	static var instances : Map<Class<Dynamic>,Dynamic>;
	static function getInstance(cls : Class<Dynamic>, ?args : Array<Dynamic>) : Null<Unknown>;
	@:has_untyped private static function init() : Void;
	static function register(inst : Dynamic, cache : Null<Bool> = false) : Void;
}
