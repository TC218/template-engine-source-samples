package rflib.common.utils;

extern class JsHelper {
	static function createInstance(constructor2 : Dynamic, ?args : Array<Dynamic>) : Dynamic;
	static function debugger() : Void;
	@:pure(inferredPure) static function getBufferOfBytes(bytes : rflib.common.Bytes) : Dynamic;
	static function isArray(val : Dynamic) : Bool;
	static function isUndefined(val : Dynamic) : Bool;
	static function jsToHaxeArray(a : Dynamic) : Array<Dynamic>;
}
