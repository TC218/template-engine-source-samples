package rflib.common.htemplate;

extern class TagHandler {
	var htemplate : rflib.common.HTemplate;
	var node : rflib.common.MarkupNode;
	var trim_line_before(get,never) : Bool;
	function new(n : rflib.common.MarkupNode, ht : rflib.common.HTemplate) : Void;
	function context(cb : () -> Void) : Void;
	private function evalAttrib(name : rflib.common.Str) : rflib.common.Dyn;
	private function evalAttribs() : rflib.common.DynAccess;
	function exec() : Void;
	@:pure(inferredPure) private function getAttribsExprTags() : rflib.common.MapExprTags;
	function getTagHandlersMap() : Map<String,Class<TagHandler>>;
	private function get_trim_line_before() : Bool;
	function init() : Void;
	function initPhase() : Void;
	function loadRelatedNodes(context_path : String) : LoadRelatedNodesResult;
	function output() : String;
}
