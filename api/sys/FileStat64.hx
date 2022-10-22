package rflib.common.sys;

extern class FileStat64 {
	@:ifFeature("rflib.common.sys.FileStat64.*") var atime : rflib.common.DatePlus;
	@:ifFeature("rflib.common.sys.FileStat64.*") var ctime : rflib.common.DatePlus;
	@:ifFeature("rflib.common.sys.FileStat64.*") var dev : Int;
	@:ifFeature("rflib.common.sys.FileStat64.*") var gid : Int;
	@:ifFeature("rflib.common.sys.FileStat64.*") var ino : Int;
	@:ifFeature("rflib.common.sys.FileStat64.*") var mode : Int;
	@:ifFeature("rflib.common.sys.FileStat64.*") var mtime : rflib.common.DatePlus;
	@:ifFeature("rflib.common.sys.FileStat64.*") var nlink : Int;
	@:ifFeature("rflib.common.sys.FileStat64.*") var rdev : Int;
	@:ifFeature("rflib.common.sys.FileStat64.*") var size : rflib.common.Int64;
	@:ifFeature("rflib.common.sys.FileStat64.*") var type : rflib.common.StatType;
	@:ifFeature("rflib.common.sys.FileStat64.*") var uid : Int;
	@:pure(inferredPure) function new() : Void;
}
