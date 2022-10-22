package rflib.common.base;

extern abstract EventId(Id) {
	@:pure(inferredPure) @:noCompletion function _new(i : Id) : EventId;
}
