package rflib.common.utils.markup;

extern class MarkupNodeSelector {
	var nodes : Array<rflib.common.MarkupNode>;
	@:pure(inferredPure) function new(nodes : Array<rflib.common.MarkupNode>) : Void;
	function query(q : String, filter_cb : Null<rflib.common.MarkupNode -> Bool> = null) : MarkupNodeSelector;
}
