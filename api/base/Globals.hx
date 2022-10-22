package rflib.common.base;

extern class Globals {
	static var B0(inline,never) : Bool;
	static var B1(inline,never) : Bool;
	static var throw_errors : Bool;
	static function P(v : Dynamic) : Void;
	static function error(a : Dynamic, ?e : Dynamic) : Void;
	static function log(a : Dynamic) : Void;
	static function logData(a : rflib.common.Dyn) : Void;
	@:pure(inferredPure) static function max(a : Int, b : Int) : Int;
	@:pure(inferredPure) static function min(a : Int, b : Int) : Int;
	static function warn(a : Dynamic) : Void;
}
