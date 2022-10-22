package rflib.common.utils;

extern class HaJson {
	@:pure(inferredPure) function new() : Void;
	private function convertTypes(val : Dynamic) : Dynamic;
	private function convertTypesReverse(val : Dynamic) : Dynamic;
	function serialize(data : Dynamic) : String;
	function unserialize(s : String) : Dynamic;
	private static var TYPE_KEY(inline,never) : String;
}
