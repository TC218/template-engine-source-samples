package rflib.common.utils.markup;

extern class HtmlMarkupNode extends MarkupNode {
	var content : Dynamic;
	@:pure(inferredPure) function new(?name : String, ?attribs : rflib.common.MarkupAttribs, ?content : Dynamic) : Void;
	function addClass(name : String) : Void;
}
