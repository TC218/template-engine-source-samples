package rflib.common.utils;

extern class BytesSegmentsList {
	private var first_seg : BytesSegment;
	private var last_seg : BytesSegment;
	private var last_seg_pos : Int;
	private var segment_size : Int;
	function new(segment_size : Int) : Void;
	function addByte(val : Int) : Void;
	function joinAll(length : Int) : rflib.common.Bytes;
	function reset() : Void;
}
