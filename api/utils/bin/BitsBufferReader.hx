package rflib.common.utils.bin;

extern class BitsBufferReader {
	private var buf : Int;
	private var bytes : rflib.common.Bytes;
	private var pos : Int;
	function new(?bytes : rflib.common.Bytes) : Void;
	function read(n : Int) : UInt;
	private function readBit() : Int;
	function readValues(lengths : Array<Int>) : Array<UInt>;
	function reset(bytes : rflib.common.Bytes) : Void;
}
