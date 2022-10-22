package rflib.common.utils.bin;

extern class BufferValuesReader {
	var bytes : rflib.common.Bytes;
	var pos : Int;
	function new(?bytes : rflib.common.Bytes) : Void;
	function init(bytes : rflib.common.Bytes) : Void;
	function readByte() : Int;
	function readBytes() : rflib.common.Bytes;
	function readDouble() : Float;
	function readInt32() : Int;
	function readString() : String;
	function readStringArray() : Array<String>;
	function readUInt16() : Int;
	function readVarInt() : Int;
	function readVarInt64() : rflib.common.Int64;
	function readVarUInt() : UInt;
}
