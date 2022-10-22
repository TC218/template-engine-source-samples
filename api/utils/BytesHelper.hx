package rflib.common.utils;

extern class BytesHelper {
	static function bytesFromHex(s : String) : haxe.io.Bytes;
	static function slice(bytes : haxe.io.Bytes, pos : Int, len : Int) : haxe.io.Bytes;
}
