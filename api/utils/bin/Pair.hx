package rflib.common.utils.bin;

extern class Pair<A,B> {
	var a : A;
	var b : B;
	@:pure(inferredPure) function new(a : A, b : B) : Void;
}
