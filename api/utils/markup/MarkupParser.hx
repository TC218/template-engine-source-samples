package rflib.common.utils.markup;

extern class MarkupParser {
	var config : MarkupConfig;
	private var cur_node : rflib.common.MarkupNode;
	private var cur_pos : Int;
	private var cur_text : String;
	private var newlines : Array<Int>;
	private var result_nodes : Array<rflib.common.MarkupNode>;
	var skip_regions : Array<MarkupSubstring>;
	@:pure(inferredPure) function new(?config : MarkupConfig) : Void;
	private function appendTextNode(new_pos : Int) : Void;
	private function createNode(name : String, ?attribs : Map<String,String>, ?text : String) : rflib.common.MarkupNode;
	@:pure(inferredPure) private function findSkipRegion(pos : Int) : MarkupSubstring;
	@:pure(inferredPure) private function getLineNo(pos : Int) : Int;
	function parse(text : String) : Array<rflib.common.MarkupNode>;
	private function parseAttribs(text : String) : Map<String,String>;
	private static var attribreg : EReg;
	static var debug(inline,never) : Bool;
	private static var equwordreg : EReg;
	private static var quotereg : EReg;
	private static var quotereg_s : String;
	private static var tagnamechars : EReg;
	private static var tagnamechars_s : String;
	private static var tagnamereg : EReg;
	private static var wordreg : EReg;
	private static var wordreg_s : String;
	static function escapeAttrib(s : String) : String;
	private static function removeEscapes(s : String) : String;
	private static function stripSlashes(s : String) : String;
	static function unescapeAttrib(s : String) : String;
}
