package rflib.common.hscript;

extern class Error {
	var e : ErrorDef;
	var line : Int;
	var origin : String;
	var pmax : Int;
	var pmin : Int;
	@:pure(inferredPure) function new(e : ErrorDef, pmin : Int, pmax : Int, ?origin : String, line : Null<Int> = 0) : Void;
	function toString() : String;
}
