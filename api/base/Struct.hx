package rflib.common.base;

@:structInit @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) extern class Struct {
	@:pure(inferredPure) @:compilerGenerated @:inheritDoc function new() : Void;
	function init() : Void;
	function toString() : String;
}
