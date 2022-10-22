package rflib.common.utils;

@:allow(rflib.common.utils.TreeObject) extern class ObjectEvent {
	private var _status : Int;
	var data : Dynamic;
	var is_halted(get,never) : Bool;
	private var listen_step : Int;
	var on_complete : ObjectEvent -> Void;
	var path_pos : Int;
	var phase : Int;
	var response : Dynamic;
	var route : ObjectRoute;
	var status(get,never) : Int;
	var type_id : rflib.common.EventId;
	private var wait_on_listener : Listener;
	@:pure(inferredPure) function new(type_id : rflib.common.EventId, ?data : Dynamic) : Void;
	@:pure(inferredPure) function get_is_halted() : Bool;
	@:pure(inferredPure) function get_status() : Int;
	function resume() : Void;
	function send(origin : TreeObject, ?target : TreeObject) : ObjectEvent;
	private function sendThroughRoute(route : ObjectRoute, resume : Null<Bool> = false) : Void;
	function stopPropagation() : Void;
	function wait() : Void;
	static var STATUS_COMPLETED(inline,never) : Int;
	static var STATUS_READY(inline,never) : Int;
	static var STATUS_RETURNING(inline,never) : Int;
	static var STATUS_SENDING(inline,never) : Int;
	static var STATUS_STOPPED(inline,never) : Int;
	static var STATUS_WAITING(inline,never) : Int;
	private static var debug(inline,never) : Bool;
}
