package rflib.common.base;

extern abstract IdClass(Id) {
	@:pure(inferredPure) @:noCompletion function _new(i : Id) : IdClass;
}
