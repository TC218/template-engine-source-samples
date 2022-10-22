package rflib.common.utils;

extern class GeomUtils {
	@:pure(inferredPure) static function intervalsOverlap(a1 : UInt, a2 : UInt, b1 : UInt, b2 : UInt) : Bool;
	@:pure(inferredPure) static function intervalsOverlap64(a1 : rflib.common.Int64, a2 : rflib.common.Int64, b1 : rflib.common.Int64, b2 : rflib.common.Int64) : Bool;
	@:pure(inferredPure) static function intervalsOverlap64_2(a0 : rflib.common.Int64, a1 : rflib.common.Int64, b0 : rflib.common.Int64, b1 : rflib.common.Int64) : Bool;
	@:pure(inferredPure) static function resizeFit(w : Float, h : Float, target_w : Float, target_h : Float) : {w : Float, h : Float};
}
