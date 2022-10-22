package rflib.common.utils;

extern class Int64Helper {
	static function fromNativeInt64(v : Dynamic) : haxe.Int64;
	static function genRandomInt64() : haxe.Int64;
	static function hex(n : Int, digits : Null<Int> = 0) : String;
	static function parseInt64(s : String) : haxe.Int64;
	static function str(i : haxe.Int64) : String;
	@:pure(inferredPure) static function toFloat(v : haxe.Int64) : Float;
	static function toHex(v : haxe.Int64, pad : Null<Int> = 0) : String;
}
