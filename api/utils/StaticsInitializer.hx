package rflib.common.utils;

extern class StaticsInitializer {
	private static var callbacks : Array<CallbackInfo>;
	private static var sorted : Bool;
	static function addCallback(cls : Class<Dynamic>, cb : () -> Void, once : Null<Bool> = false, priority : Null<Int> = 0) : Void;
	@:has_untyped static function execute(?class_priorities : haxe.ds.ObjectMap<Dynamic,Int>) : Void;
}
