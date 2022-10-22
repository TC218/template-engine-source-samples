package rflib.common.event;

extern class EventsChannel implements IEventsChannel {
	private var _filters : Array<rflib.common.Event -> Bool>;
	private var _hold : Int;
	private var listeners : Map<AbstractThread,Map<Null<Int>,Array<EventCallback>>>;
	private var mutex : rflib.common.Mutex;
	private var next : EventsChannel;
	private var persist_senders : Map<Int,Array<Sender>>;
	@:pure(inferredPure) function new() : Void;
	private function collectThreadListeners(target : Array<EventCallback>, t : AbstractThread, type_id : Int) : Void;
	private function execListeners(a : Array<EventCallback>, e : rflib.common.Event, cb : Null<Dynamic -> Void> = null) : Void;
	function filter(cb : rflib.common.Event -> Bool) : Void;
	function hasListener(type_id : Int, listener : rflib.common.Event -> (Dynamic -> Void) -> Void) : Bool;
	function hold(val : Bool) : Void;
	private function indexOfListener(type_id : Int, listener : rflib.common.Event -> (Dynamic -> Void) -> Void) : Int;
	function linkTo(chn : EventsChannel) : Void;
	function listen(type_id : Null<Int>, listener : rflib.common.Event -> (Dynamic -> Void) -> Void) : Void;
	function numListeners() : Int;
	function receiveThreadEvent(e : rflib.common.Event, cb : Null<Dynamic -> Void> = null) : Void;
	function removeListener(type_id : Null<Int>, listener : rflib.common.Event -> (Dynamic -> Void) -> Void) : Void;
	function reset() : Void;
	function send(e : rflib.common.Event, cb : Null<Dynamic -> Void> = null, persist : Null<Bool> = false) : Void;
	function unlink() : Void;
	private function validAfterFilters(e : rflib.common.Event) : Bool;
}
