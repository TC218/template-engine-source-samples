package rflib.common.utils;

@:keep extern class StringUtils {
	@:keep private static var size_r : EReg;
	@:keep private static var spaces_only_r : EReg;
	@:keep static function buildURLQuery(vars : rflib.common.Dyn) : String;
	@:keep static function compareAlphabetically(a : String, b : String) : Int;
	@:pure(inferredPure) @:keep static function compareStrings(a : String, b : String) : Int;
	@:keep static function condenseEmptyLines(s : String) : String;
	@:keep static function condenseWhitespace(s : String) : String;
	@:keep static function findTagsWrapRegionEndPos(text : String, start_pos : Int, open_tag : String, close_tag : String) : Int;
	@:keep static function findUnusedName(prefix : String, find_cb : String -> Bool) : String;
	@:keep static function floatFillZeros(n : Float, zeros : Null<Int>) : String;
	@:keep static function genRandomString(length : Int, charset : String) : String;
	@:keep static function getWords(s : String) : Array<String>;
	@:keep static function htmlAttribs(v : Dynamic, filterCb : Null<rflib.common.Str -> Bool> = null) : String;
	@:keep static function htmlTag(name : rflib.common.Str, attribs : Dynamic, ?content : rflib.common.Str) : String;
	@:keep static function indent(s : String, n : Int, condense_lines : Null<Bool> = false, ?i : String) : String;
	@:keep static function lcFirst(s : String) : String;
	@:pure(inferredPure) @:keep static function normalizeSlashes(s : String) : String;
	@:keep static function normalizeURL(s : String) : String;
	@:keep static function onEachLine(s : String, cb : String -> Void) : Void;
	@:pure(inferredPure) @:keep static function padZeros(n : Int, num_zeros : Int) : String;
	@:keep static function parseByType(s : String, t : StrDataType) : Dynamic;
	@:pure(inferredPure) @:keep static function parseOctal(v : String) : Int;
	@:keep static function parsePath(path : String) : {file : String, ext : String, dir : String};
	@:keep static function parseSize(s : String) : rflib.common.Int64;
	@:keep static function parseURLQuery(s : String) : Map<String,Dynamic>;
	@:pure(inferredPure) @:keep static function repeat(s : String, n : Null<Int>) : String;
	@:keep static function stripEmptyStrings(a : Array<String>, strip_whitespace : Null<Bool> = false) : Array<String>;
	@:keep static function stripTags(str : String, ?allowed_tags : String) : String;
	@:keep static function stripWhitespace(s : String) : String;
	@:keep static function ucFirst(s : String) : String;
	@:keep static function urlEncodePath(path : rflib.common.Str) : rflib.common.Str;
}
