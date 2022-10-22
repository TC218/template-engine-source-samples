package rflib.common.htemplate;

extern class HTemplateParser {
	private var origin : String;
	private var parser : rflib.common.hscript.Parser;
	function new() : Void;
	function parse(source : String, ?origin : String, ?markupConfig : rflib.common.MarkupConfig) : Array<rflib.common.MarkupNode>;
	private function parseMapExprs(map : Map<String,Dynamic>) : rflib.common.MapExprTags;
	private function parseNodeDataExpr(n : rflib.common.MarkupNode) : Void;
	private function parseNodeExprs(n : rflib.common.MarkupNode) : rflib.common.MarkupNodeExprTags;
	private function parseScript(script : String, ?origin : String, line : Int = 0) : rflib.common.hscript.Expr;
	private function parseTextExprs(s : String) : Array<rflib.common.ExprTag>;
	private static var tagreg : EReg;
	private static function findTextExprs(s : String) : Array<rflib.common.MarkupSubstring>;
}
