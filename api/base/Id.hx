package rflib.common.base;

extern abstract Id(Int) {
	@:pure(inferredPure) @:noCompletion function _new(i : Int) : Id;
}
