package rflib.common.utils;

extern class ArrayUtils {
	static function add<T>(a : Array<T>, src : Array<Dynamic>) : Array<T>;
	static function arrayString(a : Array<Dynamic>, v : Dynamic) : String;
	static function shuffle<T>(a : Array<T>) : Array<T>;
}
