package rflib.common.filter;

extern class BoolFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	@:keep static var allowed_input_types : Array<rflib.common.ValueType>;
	@:keep static var name : String;
	@:keep static var type : rflib.common.ValueType;
}
