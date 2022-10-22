package rflib.common.base;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) extern class AppObjectFilter<T> extends Struct {
	@expose var cb : T -> Bool;
	@expose var class_ : Class<T>;
	@expose var except : AppObjectFilter<AppObject>;
	@expose var extensionClass : Class<rflib.common.Dyn>;
	@expose var fields : Dynamic;
	@expose var max_match_depth : Null<Int>;
	function new(?class_ : Class<T>, ?extensionClass : Class<rflib.common.Dyn>, ?fields : Dynamic, cb : Null<T -> Bool> = null, ?except : AppObjectFilter<AppObject>, max_match_depth : Null<Int> = 0) : Void;
	static var __meta__ : Dynamic;
}
