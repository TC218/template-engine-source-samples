package rflib.common.filter;

extern class EmailFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	@:skipObfuscation @:keep static var name : String;
	private static var reg : EReg;
	@:keep static var type : rflib.common.ValueType;
}
