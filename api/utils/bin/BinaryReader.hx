package rflib.common.utils.bin;

extern class BinaryReader extends BufferValuesReader {
	private var bits_r : rflib.common.BitsBufferReader;
	private var containers_sizes_offsets(get,never) : Bool;
	private var hash : rflib.common.Bytes;
	private var hash_type : BinaryFormatHashType;
	private var local_symbols : Array<String>;
	private var packet_desc : Int;
	private var sizes : Array<UInt>;
	private var sizes_pos : Int;
	private var symbols : Array<String>;
	private var symbols_hashes : Map<Int,Int>;
	private var total_size : UInt;
	function new() : Void;
	@:pure(inferredPure) private function get_containers_sizes_offsets() : Bool;
	private function readClassInstance() : Unknown;
	private function readEnum() : EnumValue;
	function readFromStream(recv : UInt -> rflib.common.Bytes, bufsize : Null<Int> = 0) : Dynamic;
	function readPacketFromStream(recv : UInt -> rflib.common.Bytes, bufsize : Null<Int> = 0) : rflib.common.Bytes;
	private function readVal(eltype : Null<Int> = 0) : Dynamic;
	function reset() : BinaryReader;
	private function symbolsHashAt(index : Int) : Int;
	function unserialize(bytes : rflib.common.Bytes) : Dynamic;
	private static var DEFAULT_BUFSIZE(inline,never) : Int;
}
