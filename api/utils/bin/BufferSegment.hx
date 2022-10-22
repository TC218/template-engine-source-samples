package rflib.common.utils.bin;

extern class BufferSegment {
	var len : Int;
	var pos : Null<Int>;
	@:pure(inferredPure) function new(pos : Null<Int> = 0, len : Null<Int> = 0) : Void;
	function initPos(pos : Int) : Void;
	function reset() : BufferSegment;
}
