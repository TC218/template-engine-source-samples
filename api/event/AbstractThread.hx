package rflib.common.event;

extern class AbstractThread {
	private var _id : Int;
	var id(get,never) : Int;
	var platform_thread : rflib.common.Thread;
	@:pure(inferredPure) function new(pt : rflib.common.Thread, id : Int) : Void;
	@:pure(inferredPure) private function get_id() : Int;
	function onDestroy() : Void;
	function toString() : String;
	static var EXIT : Int;
}
