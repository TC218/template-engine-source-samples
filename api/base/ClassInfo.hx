package rflib.common.base;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) extern class ClassInfo extends Struct {
	@expose var name : String;
	@expose var pkg : String;
	function new(pkg : String, name : String) : Void;
	static var __meta__ : Dynamic;
}
