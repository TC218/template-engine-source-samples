package rflib.common.event;

extern class DummyMutex {
	@:pure(inferredPure) function new() : Void;
	function acquire() : Void;
	function release() : Void;
	function tryAcquire() : Void;
}
