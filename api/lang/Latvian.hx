package rflib.common.lang;

@:keep extern class Latvian {
	@:keep private static var A : Int;
	@:keep private static var D : Int;
	@:keep private static var G : Int;
	@:keep private static var I : Int;
	@:keep private static var L : Int;
	@:keep private static var N : Int;
	@:keep private static var V : Int;
	@:keep private static var suffixes : rflib.common.IntMap<Array<rflib.common.IntMap<String>>>;
	@:keep private static var this_word : Array<Array<rflib.common.IntMap<String>>>;
	@:keep static function morph(w : Word, plural : Null<Bool> = false, ?g_case : GrammaticalCase) : String;
	@:keep static function parseWord(word : String) : Word;
	@:pure(inferredPure) @:keep static function thisWord(g_case : GrammaticalCase, is_feminine : Null<Bool> = false, plural : Null<Bool> = false) : String;
}
