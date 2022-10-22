package rflib.common.filter;

extern class PhoneFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	private static var charset : String;
	private static var max_len : Int;
	private static var min_len : Int;
	@:skipObfuscation @:keep static var name : String;
	@:keep static var type : rflib.common.ValueType;
}
