package rflib.common.sys;

extern class TerminalPercentsUpdater extends rflib.common.utils.Updater {
	var clear_after : Bool;
	var pos : Float;
	private var prev_chars : Int;
	@:pure(inferredPure) function new() : Void;
}
