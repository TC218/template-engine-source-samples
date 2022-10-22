package rflib.common.filter;

@:allow(rflib.common.filter.FiltersChain) extern class Filter {
	private var _methods : Map<String,Dynamic -> Dynamic>;
	var default_val(get,never) : Dynamic;
	var defines_type(get,set) : Bool;
	var flags : Int;
	private var method : Dynamic -> Dynamic;
	private var method_name : String;
	private var methods(get,never) : Map<String,Dynamic -> Dynamic>;
	var options : Dynamic;
	var required(get,never) : Bool;
	var smart_parse(get,set) : Bool;
	private var type_desc : String;
	var validate(get,set) : Bool;
	function new(type_desc : String, method_name : String, convert : Bool, ?options : Dynamic) : Void;
	function align(val : Dynamic) : Dynamic;
	private function get_default_val() : Dynamic;
	@:pure(inferredPure) private function get_defines_type() : Bool;
	private function get_methods() : Map<String,Dynamic -> Dynamic>;
	private function get_required() : Bool;
	@:pure(inferredPure) private function get_smart_parse() : Bool;
	@:pure(inferredPure) private function get_validate() : Bool;
	@:pure(inferredPure) function hasOpt(key : String) : Bool;
	private function init() : Void;
	function input(val : Dynamic) : Dynamic;
	@:has_untyped private function log(v : Dynamic) : Void;
	function setOpt(key : String, val : Dynamic) : Void;
	private function set_defines_type(v : Bool) : Bool;
	private function set_smart_parse(v : Bool) : Bool;
	private function set_validate(v : Bool) : Bool;
	function toString(val : Dynamic) : String;
	static var DEFINES_TYPE(inline,never) : Int;
	static var SMART_PARSE(inline,never) : Int;
	static var VALIDATE(inline,never) : Int;
	static function fdefHasFilter(def : Dynamic, fname : String) : Bool;
	static function mergeDef(a : Dynamic, b : Dynamic) : Dynamic;
}
