package rflib.common.view;

extern class AppObjectTagHandler extends TextViewTagHandler {
	private var _attribs : rflib.common.MarkupAttribs;
	var app_object : rflib.common.AppObject;
	var attribs(get,set) : rflib.common.MarkupAttribs;
	function new(n : rflib.common.MarkupNode, ht : rflib.common.HTemplate) : Void;
	function getInterpretedAttribs() : rflib.common.MarkupAttribs;
	@:pure(inferredPure) private function get_attribs() : rflib.common.MarkupAttribs;
	private function set_attribs(v : rflib.common.MarkupAttribs) : rflib.common.MarkupAttribs;
}
