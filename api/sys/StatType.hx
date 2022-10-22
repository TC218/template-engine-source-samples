package rflib.common.sys;

extern enum abstract StatType(Int) {
	var BLOCK_DEVICE;
	var CHAR_DEVICE;
	var DIRECTORY;
	var FIFO;
	var REGULAR_FILE;
	var SOCKET;
	var SYMLINK;
	var UNKNOWN;
}
