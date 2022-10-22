package rflib.common.utils;

extern class RangeHelper {
	@:pure(inferredPure) static function matchRange(val : Int, r : Range) : Bool;
	static function parseRange(s : String) : Range;
}
