package rflib.common.filter;

extern class FiltersChain {
	var default_val(get,never) : Dynamic;
	var filters : Array<Filter>;
	var map : Map<String,Filter>;
	var required(get,never) : Bool;
	var smart_parse(get,set) : Bool;
	var validate(get,set) : Bool;
	@:pure(inferredPure) function new() : Void;
	function addFilter(flt : Filter) : FiltersChain;
	function getById(id : String) : Filter;
	function getFilter(type_desc : String, ?has_options : Array<String>) : Filter;
	private function get_default_val() : Dynamic;
	private function get_required() : Bool;
	private function get_smart_parse() : Bool;
	private function get_validate() : Bool;
	function hasFilter(type_desc : String) : Bool;
	function iterator() : haxe.iterators.ArrayIterator<Filter>;
	function process(val : Dynamic) : Dynamic;
	private function set_smart_parse(val : Bool) : Bool;
	private function set_validate(val : Bool) : Bool;
}
