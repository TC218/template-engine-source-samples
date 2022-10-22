package rflib.common.utils;

extern class DateTools2 {
	private static var DAYS_OF_MONTH : Array<Int>;
	static var DAY_NAMES : Array<String>;
	static var DAY_SHORT_NAMES : Array<String>;
	static var MONTH_NAMES : Array<String>;
	static var MONTH_SHORT_NAMES : Array<String>;
	private static function __format(d : Date, f : String, ?dt : DateTexts) : String;
	@:has_untyped private static function __format_get(d : Date, e : String, ?dt : DateTexts) : String;
	@:pure(inferredPure) static function days(n : Float) : Float;
	@:pure(inferredPure) static function delta(d : Date, t : Float) : Date;
	static function format(d : Date, f : String, ?dt : DateTexts) : String;
	static function getMonthDays(d : Date) : Int;
	@:pure(inferredPure) static function hours(n : Float) : Float;
	@:pure(inferredPure) static function make(o : {seconds : Int, ms : Float, minutes : Int, hours : Int, days : Int}) : Float;
	@:has_untyped static function makeUtc(year : Int, month : Int, day : Int, hour : Int, min : Int, sec : Int) : Float;
	@:pure(inferredPure) static function minutes(n : Float) : Float;
	@:pure(inferredPure) static function parse(t : Float) : {seconds : Int, ms : Float, minutes : Int, hours : Int, days : Int};
	@:pure(inferredPure) static function seconds(n : Float) : Float;
}
