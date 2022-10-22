package rflib.common.utils;

extern class OrderedMap<V> {
	var keys_map : Map<K,Int>;
	var values : Array<{v : V, k : K}>;
	@:pure(inferredPure) function new() : Void;
	@:pure(inferredPure) function get(k : K) : V;
	function iterator() : Iterator<V>;
	function keys() : Array<K>;
	function set(key : K, val : V) : V;
}
