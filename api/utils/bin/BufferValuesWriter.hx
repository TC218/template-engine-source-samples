package rflib.common.utils.bin;

extern class BufferValuesWriter {
	var buf : BufferSegment;
	var calc_size : Bool;
	var result_bytes : rflib.common.Bytes;
	@:pure(inferredPure) function new(?buf : BufferSegment) : Void;
	function writeByte(val : Int) : Void;
	function writeBytes(b : rflib.common.Bytes) : Void;
	function writeDouble(val : Float) : Void;
	function writeString(val : String) : Void;
	function writeStringArray(a : Array<String>) : Void;
	function writeUInt16(val : Int) : Void;
	function writeVarInt(val : Int) : Void;
	function writeVarInt64(val : rflib.common.Int64) : Void;
	function writeVarUInt(val : UInt) : Void;
}
