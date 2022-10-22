package rflib.common.ds;

extern class ObjectMap2<V> {
	var m : rflib.common.ObjectMap<V>;
	@:pure(inferredPure) function new() : Void;
	@:pure(inferredPure) function get(o : rflib.common.Dyn) : V;
	function set(o : rflib.common.Dyn, v : V) : V;
}
