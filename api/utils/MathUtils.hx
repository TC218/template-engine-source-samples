package rflib.common.utils;

extern class MathUtils {
	@:pure(inferredPure) static function max(a : Float, b : Float) : Float;
	@:pure(inferredPure) static function min(a : Float, b : Float) : Float;
	@:pure(inferredPure) static function roundDecimals(v : Float, places : Int) : Float;
	@:pure(inferredPure) static function sign(n : Float) : Int;
}
