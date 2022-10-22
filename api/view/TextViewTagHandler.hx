package rflib.common.view;

extern class TextViewTagHandler extends rflib.common.htemplate.TagHandler {
	var view(get,never) : rflib.common.TextView;
	function new(n : rflib.common.MarkupNode, ht : rflib.common.HTemplate) : Void;
	function getScopeVariables() : rflib.common.TextViewVars;
	@:pure(inferredPure) private function get_view() : rflib.common.TextView;
}
