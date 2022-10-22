package rflib.common.utils;

@:allow(rflib.common.utils.TreeObject) extern class Tree {
	private var _root : TreeObject;
	private var id_counter : Int;
	var objects_ids : Map<Int,TreeObject>;
	var root(get,set) : TreeObject;
	function new(?root : TreeObject, use_objects_ids : Null<Bool> = false) : Void;
	@:pure(inferredPure) function get_root() : TreeObject;
	function set_root(val : TreeObject) : TreeObject;
}
