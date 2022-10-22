package rflib.common.utils;

extern class SubtreeObject extends TreeObject {
	private var _subtree : Tree;
	var subtree(get,never) : Tree;
	function new() : Void;
	@:pure(inferredPure) function get_subtree() : Tree;
	function linkSubtree(t : Tree) : Void;
}
