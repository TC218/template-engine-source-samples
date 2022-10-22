package rflib.common.htemplate;

@:allow(rflib.common.htemplate.TagHandler) extern class HTemplate {
	var context : HTemplateContext;
	private var markupConfig : rflib.common.MarkupConfig;
	var nodes : Array<rflib.common.MarkupNode>;
	var owner : Dynamic;
	var selector : rflib.common.MarkupNodeSelector;
	function new(nodes : Array<rflib.common.MarkupNode>) : Void;
	function exec(?nodes_arg : Array<rflib.common.MarkupNode>) : Void;
	function fillExprTags(text : String, tags : Array<rflib.common.ExprTag>) : Dynamic;
	function fillMapExprs(expr_tags : rflib.common.MapExprTags, map : Map<String,Dynamic>) : Map<String,Dynamic>;
	private function formattedTrim(s : String) : String;
	function init() : Void;
	function initPhase(?nodes_arg : Array<rflib.common.MarkupNode>) : Void;
	private function initTagHandlerByName(name : String, node : rflib.common.MarkupNode) : rflib.common.TagHandler;
	private function initTags(ns : Array<rflib.common.MarkupNode>) : Void;
	private function nodeTagHandlerContext(n : rflib.common.MarkupNode, cb : rflib.common.TagHandler -> Void) : Void;
	function output(?nodes_arg : Array<rflib.common.MarkupNode>) : String;
	private function outputSingleNode(n : rflib.common.MarkupNode, prev_output : {s : String}) : String;
	function setContext() : Void;
	private function testSpaces() : Void;
	function treeTagHandlerContext(?nodes_arg : Array<rflib.common.MarkupNode>, cb : rflib.common.TagHandler -> Void) : Void;
	static var hscript_error_index : Int;
	private static var spaces_prefix : EReg;
	private static var spaces_suffix : EReg;
	private static var spc_r : EReg;
	static function getDefaultContext(?vars : Dynamic) : HTemplateContext;
	static function getDefaultTagHandlersMap() : Map<String,Class<rflib.common.TagHandler>>;
}
