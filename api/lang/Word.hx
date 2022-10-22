package rflib.common.lang;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) @:keep extern class Word extends rflib.common.base.Struct {
	@:keep @expose var declension : LatvianDeclension;
	@:keep @expose var g_case : GrammaticalCase;
	@:keep @expose var is_feminine : Bool;
	@:keep @expose var is_plural : Bool;
	@:keep @expose var root : String;
	@:keep @expose var suffix : String;
	@:keep @expose var word : String;
	@:keep function new(word : String, root : String, suffix : String, is_plural : Bool, declension : LatvianDeclension, is_feminine : Bool, g_case : GrammaticalCase) : Void;
	@:keep function morph(plural : Null<Bool> = false, ?g_case : GrammaticalCase) : String;
	static var __meta__ : Dynamic;
}
