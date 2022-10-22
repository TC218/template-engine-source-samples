package rflib.common.view.tag;

extern class SwitchTag extends rflib.common.view.TextViewTagHandler {
	function new(n : rflib.common.MarkupNode, ht : rflib.common.HTemplate) : Void;
	private static var handlers : Map<String,Class<rflib.common.TagHandler>>;
}
