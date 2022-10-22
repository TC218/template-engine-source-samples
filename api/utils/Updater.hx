package rflib.common.utils;

extern class Updater {
	var on_trigger_cbs : rflib.common.VoidCallbackList;
	private var t0 : Float;
	var trigger_delay : Float;
	var update_interval : Float;
	var updated : Bool;
	@:pure(inferredPure) function new() : Void;
	function finish() : Void;
	function forceUpdate() : Void;
	private function onTrigger() : Void;
	function reset() : Void;
	function setTimes(update_interval : Null<Float>, trigger_delay : Null<Float> = 0) : Void;
	function tryUpdate(force : Bool = false) : Void;
	private function update(first : Bool) : Void;
}
