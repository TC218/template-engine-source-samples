package rflib.common.event;

extern class DummyThread {
	var handle(default,null) : rflib.common.ThreadHandle;
	@:pure(inferredPure) function new() : Void;
	function sendMessage(msg : Dynamic) : Void;
	private static var _cur : DummyThread;
	@:pure(inferredPure) static function create(cb : () -> Void) : DummyThread;
	static function current() : DummyThread;
	@:pure(inferredPure) static function readMessage(block : Bool) : Dynamic;
}
