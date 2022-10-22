package rflib.common.utils;

extern class AssetPointer {
	private var _context_path : String;
	private var _local_path : String;
	var context_path(get,never) : String;
	var local_path(get,never) : String;
	var path(get,never) : String;
	@:pure(inferredPure) function new(local_path : String, ?context_path : String) : Void;
	function enterContext(cb : () -> Void) : Void;
	@:pure(inferredPure) function get_context_path() : String;
	@:pure(inferredPure) function get_local_path() : String;
	function get_path() : String;
	function load(cb : Dynamic -> haxe.io.Bytes -> Void) : Void;
	function loadSync() : haxe.io.Bytes;
	function stat(cb : Dynamic -> AssetStat -> Void) : Void;
	function statSync() : AssetStat;
	function toString() : String;
}
