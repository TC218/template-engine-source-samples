package rflib.common.filter;

extern class StrFilter extends Filter {
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	function filterCondenseSpace(val : String) : String;
	function filterIndent(val : String) : String;
	function filterLength(val : String) : String;
	function filterLowerCase(val : String) : String;
	function filterStripSpaces(val : String) : String;
	function filterTrim(val : String) : String;
	function filterUpperCase(val : String) : String;
	@:keep static var allowed_input_types : Array<rflib.common.ValueType>;
	@:skipObfuscation @:keep static var name : String;
	@:keep static var type : rflib.common.ValueType;
}
