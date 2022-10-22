package rflib.common.hscript;

extern class HScriptDataWriter {
	var ids_comments : Bool;
	private var level : Int;
	var more_newlines : Bool;
	var objects : rflib.common.Arr<rflib.common.Dyn>;
	var objectsIndexes : rflib.common.ObjectMap2<Int>;
	@:pure(inferredPure) function new() : Void;
	function serialize(val : Dynamic, ?meta : DynMap) : String;
	private static function isContainer(v : Dynamic) : Bool;
}
