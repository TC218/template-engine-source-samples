package rflib.common.hscript;

@:structInit extern class Expr {
	var e : ExprDef;
	var line : Int;
	var origin : String;
	var pmax : Int;
	var pmin : Int;
	@:pure(inferredPure) @:compilerGenerated @:inheritDoc function new(e : ExprDef, pmin : Int, pmax : Int, origin : String, line : Int) : Void;
}
