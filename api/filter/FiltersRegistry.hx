package rflib.common.filter;

extern class FiltersRegistry {
	var filters : Map<String,Class<rflib.common.Filter>>;
	function new() : Void;
	function createFilter(type : String, ?options : Dynamic) : rflib.common.Filter;
	function createFilterFromData(fdef : Dynamic) : rflib.common.Filter;
	function createFilters(options : Dynamic) : rflib.common.FiltersChain;
	function registerFilter(fcls : Class<rflib.common.Filter>) : Void;
	private static var default_filters : Array<Class<rflib.common.Filter>>;
}
