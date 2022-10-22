package rflib.common.htemplate;

extern class HTemplateAssetLoader {
	private static var cache : Map<String,rflib.common.htemplate.priv_HTemplateAssetLoader.HTemplateCacheEntry>;
	private static var debug : Bool;
	private static var parser : rflib.common.HTemplateParser;
	private static var single_line_comment : EReg;
	static function loadTemplate(asset : rflib.common.AssetPointer, ?markupConfig : rflib.common.MarkupConfig) : Array<rflib.common.MarkupNode>;
	@:has_untyped private static function log(a : Dynamic) : Void;
}
