package rflib.common.base;

extern abstract StringId(Int) {
	@:pure(inferredPure) @:noCompletion function _new(i : Int) : StringId;
}
