package rflib.common.base;

extern class HException {
	var code : Null<Int>;
	var msg : String;
	var object : Dynamic;
	var pos : rflib.common.PosInfos;
	@:pure(inferredPure) function new(code : Null<Int> = 0, ?msg : String, ?object : Dynamic, ?pos : rflib.common.PosInfos) : Void;
	function toString() : String;
}
