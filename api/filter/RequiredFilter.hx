package rflib.common.filter;

extern class RequiredFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	@:keep static var name : String;
	@:keep static var type : rflib.common.ValueType;
}
