package rflib.common.utils;

extern class FunctionArgs<CBT> {
	var args : Array<Dynamic>;
	var fn : CBT;
	@:pure(inferredPure) function new(fn : CBT, ?args : Array<Dynamic>) : Void;
}
