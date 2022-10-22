package rflib.common.utils;

@:structInit @:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:build(rflib.common.macro.BuildMacros.buildStruct()) @:autoBuild(rflib.common.macro.BuildMacros.buildStruct()) extern class ListenerStruct extends rflib.common.base.Struct {
	@expose var data : Dynamic;
	@expose var event_type_id : rflib.common.EventId;
	@expose var filter_cb : ObjectEvent -> Bool;
	@expose var listen_cb : ObjEvent -> Listener -> Void;
	@expose var phase : Int;
	@expose var priority : Int;
	@expose var source : Int;
	function new(event_type_id : rflib.common.EventId, listen_cb : ObjEvent -> Listener -> Void, source : Int, phase : Int, filter_cb : Null<ObjectEvent -> Bool> = null, priority : Null<Int> = 0, ?data : Dynamic) : Void;
	static var __meta__ : Dynamic;
}
