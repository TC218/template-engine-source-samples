package rflib.common.filter;

extern class IntFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	private function fromString(val : String) : Null<Int>;
	@:keep static var allowed_input_types : Array<rflib.common.ValueType>;
	private static var int_r : EReg;
	@:skipObfuscation @:keep static var name : String;
	@:keep static var type : rflib.common.ValueType;
}
