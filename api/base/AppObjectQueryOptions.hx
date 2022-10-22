package rflib.common.base;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) extern class AppObjectQueryOptions extends Struct {
	@expose var children_first : Bool;
	@expose var st : Bool;
	function new(children_first : Bool = false, st : Bool = false) : Void;
	static var __meta__ : Dynamic;
}
