package rflib.common.base;

extern class DatePlus {
	var date : Date;
	var nsec : UInt;
	@:pure(inferredPure) function new(d : Date, nsec : Null<UInt> = 0) : Void;
	function compare(b : DatePlus) : Int;
	function toString() : String;
	static function compareDates(a : Date, b : Date) : Int;
	@:pure(inferredPure) private static function compareUInts(a : UInt, b : UInt) : Int;
}
