package rflib.common.filter;

extern class FilterException {
	var code : String;
	var filter : Filter;
	var msg : String;
	var val : Dynamic;
	@:pure(inferredPure) function new(filter : Filter, val : Dynamic, code : String, ?msg : String) : Void;
}
