package rflib.common.view.tag;

extern class ViewTag extends rflib.common.view.AppObjectTagHandler {
	private var pkg : String;
	var subview : rflib.common.TextView;
	function new(n : rflib.common.MarkupNode, ht : rflib.common.HTemplate) : Void;
	static var default_view_class : Class<rflib.common.TextView>;
}
