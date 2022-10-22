package rflib.common.utils;

extern class BytesSegment {
	var bytes : rflib.common.Bytes;
	var next : BytesSegment;
	function new(size : Int) : Void;
	function joinAll(length : Int) : rflib.common.Bytes;
}
