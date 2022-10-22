package rflib.common.view;

@:keepIfUsed(["haxe.ds.StringMap", "haxe.ds.IntMap", "haxe.ds.ObjectMap"]) @:allow(rflib.common.view.TextView) @:allow(rflib.common.view.TextViewTagHandler) extern class TextViewContext {
	private var _htcontext : rflib.common.HTemplateContext;
	private var _id : Int;
	var app_objects_stack : Array<rflib.common.AppObject>;
	private var default_html_esc : Bool;
	var htcontext(get,never) : rflib.common.HTemplateContext;
	var id(get,never) : Int;
	private var id_gen_groups : Map<rflib.common.Id,Int>;
	private var interp : rflib.common.hscript.Interp;
	var outbuf_stack : Array<String>;
	var tag_handlers_map_stack : Array<TagHandlersMap>;
	var tag_handlers_stack : Array<rflib.common.TagHandler>;
	var vars_cache_stack : Array<TextViewVars>;
	var vars_stack : Array<TextViewVars>;
	function new() : Void;
	function callMacro(name : String, params : Dynamic, ?return_vars : Array<String>) : Dynamic;
	function captureOutput(cb : () -> Void) : String;
	function exists(k : String, look_levels : Null<Int> = 0) : Bool;
	function genId(group : String) : Int;
	function get(k : String) : Dynamic;
	private function get_htcontext() : rflib.common.HTemplateContext;
	@:pure(inferredPure) function get_id() : Int;
	function handlersMapContext(handlers : Map<String,Class<rflib.common.TagHandler>>, cb : () -> Void) : Void;
	@:pure(inferredPure) function hasScope() : Bool;
	function macroExists(name : String) : Bool;
	function print(s : String) : Void;
	function scope(cb : () -> Void, ?map : TextViewVars) : Void;
	function set(k : String, val : Dynamic) : Dynamic;
	function setExternal(k : String, val : Dynamic) : Dynamic;
	function snapshot() : TextViewContext;
	private static var _id_counter : Int;
	static function dumpVars(va : Array<TextViewVars>) : Array<Map<String,Dynamic>>;
}
