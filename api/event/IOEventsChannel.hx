package rflib.common.event;

extern class IOEventsChannel implements IEventsChannel {
	var input : EventsChannel;
	var output : EventsChannel;
	@:pure(inferredPure) function new() : Void;
	function filter(cb : Event -> Bool) : Void;
	function hasListener(type_id : Int, listener : Event -> (Dynamic -> Void) -> Void) : Bool;
	function hold(val : Bool) : Void;
	function listen(type_id : Null<Int>, listener : Event -> (Dynamic -> Void) -> Void) : Void;
	function numListeners() : Int;
	function removeListener(type_id : Null<Int>, listener : Event -> (Dynamic -> Void) -> Void) : Void;
	function reset() : Void;
	function send(e : Event, cb : Null<Dynamic -> Void> = null, persist : Null<Bool> = false) : Void;
}
