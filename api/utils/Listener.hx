package rflib.common.utils;

extern class Listener {
	var data : Dynamic;
	var event_type_id : rflib.common.EventId;
	var filter_cb : ObjectEvent -> Bool;
	var listen_cb : ObjEvent -> Listener -> Void;
	var phase : Int;
	var priority : Int;
	var source : Int;
	@:pure(inferredPure) function new(event_type_id : rflib.common.EventId, listen_cb : ObjEvent -> Listener -> Void, source : Int, phase : Int, filter_cb : Null<ObjectEvent -> Bool> = null, priority : Null<Int> = 0) : Void;
	function setData(data : Dynamic) : Listener;
	static var PHASE_AT_TARGET(inline,never) : Int;
	static var PHASE_NONE(inline,never) : Int;
	static var PHASE_RETURN(inline,never) : Int;
	static var PHASE_SEND(inline,never) : Int;
	static var SOURCE_INNER_WALK(inline,never) : Int;
	static var SOURCE_INPUT(inline,never) : Int;
	static var SOURCE_ORIGIN(inline,never) : Int;
	static var SOURCE_OUTPUT(inline,never) : Int;
	static var SOURCE_UNDEFINED(inline,never) : Int;
	static function fromStruct(s : ListenerStruct) : Listener;
}
