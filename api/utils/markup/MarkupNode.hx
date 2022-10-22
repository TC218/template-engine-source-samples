package rflib.common.utils.markup;

extern class MarkupNode {
	var attribs : MarkupAttribs;
	var children : Array<MarkupNode>;
	var data : Dynamic;
	var handler : Dynamic;
	var is_open : Bool;
	var is_special : Bool;
	var line_no : Int;
	var name : String;
	var next : MarkupNode;
	var parent : MarkupNode;
	var prev : MarkupNode;
	var text : String;
	var text_pos : Int;
	@:pure(inferredPure) function new(?name : String, ?attribs : MarkupAttribs, ?text : String) : Void;
	function addChild(n : MarkupNode) : Void;
	@:keep function append(n : MarkupNode) : MarkupNode;
	function eachChildByName(name : String, fn : MarkupNode -> Void) : Void;
	function eachNodeByName(name : String, fn : MarkupNode -> Int -> Void, level : Null<Int> = 0) : Void;
	function getChildByAttrib(attr : String, val : String) : MarkupNode;
	function getChildByName(name : String) : MarkupNode;
	function getFirstNodeByName(name : String) : MarkupNode;
	function getMarkupConfig() : MarkupConfig;
	function getNodesByName(name : String, ?nodes : Array<MarkupNode>) : Array<MarkupNode>;
	function getText(recurse : Null<Bool> = false) : String;
	function hasParent(p : MarkupNode) : Bool;
	@:keep function remove() : Void;
	function setData(key : rflib.common.Str, val : rflib.common.Dyn) : Void;
	function setText(s : String) : Void;
	function toString() : String;
	static function cloneNodes(a : Array<MarkupNode>, ?parent : MarkupNode, cb : Null<MarkupNode -> MarkupNode -> Void> = null) : Array<MarkupNode>;
}
