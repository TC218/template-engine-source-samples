package rflib.common.utils;

extern class OrderedMapIterator<V> {
	private var i : Int;
	private var map : OrderedMap<V>;
	@:pure(inferredPure) function new(map : OrderedMap<V>) : Void;
	@:pure(inferredPure) function hasNext() : Bool;
	@:pure(inferredPure) function next() : V;
}
