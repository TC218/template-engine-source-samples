package rflib.common.utils.bin;

extern class BitsBufferWriter {
	private var byte : Int;
	var length : Int;
	private var segments : rflib.common.BytesSegmentsList;
	function new() : Void;
	function getBytes() : rflib.common.Bytes;
	function reset() : Void;
	function write(val : UInt, n : UInt) : Void;
	private function writeBit(v : Int) : Void;
	function writeValues(values : Array<UInt>, lengths : Array<Int>) : Bool;
}
