package rflib.common.sys;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) extern class SystemExit extends rflib.common.base.Struct {
	@expose var code : Int;
	@expose var message : rflib.common.Str;
	@:pure(inferredPure) function new(code : Int, ?message : rflib.common.Str) : Void;
	static var __meta__ : Dynamic;
}
