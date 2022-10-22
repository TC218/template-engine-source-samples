package rflib.common.filter;

extern class UintFilter extends IntFilter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	static var allowed_input_types : Array<rflib.common.ValueType>;
	static var name : String;
	static var type : rflib.common.ValueType;
}
