package rflib.common.utils.bin;

extern class BinaryWriter extends BufferValuesWriter {
	private var bits : rflib.common.BitsBufferWriter;
	private var containers_sizes_offsets(get,never) : Bool;
	private var content_buf : rflib.common.BufferSegment;
	var debug : Bool;
	private var hash_buf : rflib.common.BufferSegment;
	private var hash_type : BinaryFormatHashType;
	private var head_buf : rflib.common.BufferSegment;
	private var hvt : rflib.common.ValueType;
	private var packet_desc : Int;
	private var packet_symbols_start_at : Int;
	private var param_flags : Int;
	private var size_int_len : UInt;
	private var sizes : Array<UInt>;
	private var sizes_buf : rflib.common.BufferSegment;
	private var sort_keys(get,never) : Bool;
	private var symbols_buf : rflib.common.BufferSegment;
	private var symbols_count : Int;
	private var symbols_hashes : Map<Int,Int>;
	private var symbols_map : Map<String,Int>;
	private var total_size : UInt;
	@:pure(inferredPure) function new(param_flags : Null<Int> = 0) : Void;
	function finishWrite() : Void;
	@:pure(inferredPure) private function get_containers_sizes_offsets() : Bool;
	@:pure(inferredPure) private function get_sort_keys() : Bool;
	function serialize(val : Dynamic, hash_type : Null<BinaryFormatHashType> = null) : rflib.common.Bytes;
	private function symbolIndex(s : String) : Int;
	private function symbolsHashAt(index : Int) : Int;
	private function valType(val : Dynamic) : Int;
	private function writeVal(val : Dynamic, write_type : Null<Bool> = false) : Void;
	static var F_CONTAINERS_SIZES_OFFSETS(inline,never) : Int;
	static var F_SORT_KEYS(inline,never) : Int;
}
