package rflib.common.utils;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) extern class ObjectRoute extends rflib.common.base.Struct {
	@expose var origin : TreeObject;
	@expose var path : Array<Int>;
	@expose var path_objects : Map<Int,TreeObject>;
	@expose var target : TreeObject;
	@expose var twoparts_common_parent_pos : Int;
	function new(path : Array<Int>, origin : TreeObject, target : TreeObject, twoparts_common_parent_pos : Int, ?path_objects : Map<Int,TreeObject>) : Void;
	static var __meta__ : Dynamic;
}
