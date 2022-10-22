package rflib.common.filter;

extern class DateFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	private function getFormat() : String;
	@:keep static var allow_null : Bool;
	@:keep static var allowed_input_types : Array<rflib.common.ValueType>;
	static var default_format : String;
	@:skipObfuscation @:keep static var name : String;
	static var standard_format : String;
	private static var std_date_r : EReg;
	private static var std_datetime_r : EReg;
	@:keep static var type : rflib.common.ValueType;
	static function dateFromFormat(v : String, format : String) : Date;
}
