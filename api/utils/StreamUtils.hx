package rflib.common.utils;

extern class StreamUtils {
	static var max_buf_length : UInt;
	static function recvStreamBlocks(length : rflib.common.Int64, recv : rflib.common.Bytes -> UInt -> UInt, max_buf_length : Null<UInt> = 0) : Void;
}
