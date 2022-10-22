package rflib.common.filter;

extern class CurrencyFilter extends FloatFilter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	static var allowed_input_types : Array<rflib.common.ValueType>;
	static var name : String;
	static var type : rflib.common.ValueType;
}
