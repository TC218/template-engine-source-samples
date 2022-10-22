package rflib.common.event;

extern class Event {
	var data : Dynamic;
	var name(get,never) : String;
	var propagate : Bool;
	var source_thread : AbstractThread;
	var type_id : Int;
	@:pure(inferredPure) function new(type_id : Int, ?data : Dynamic) : Void;
	@:pure(inferredPure) private function get_name() : String;
	function toString() : String;
	private static var t_counter : Null<Int>;
	private static var types : Map<String,Int>;
	static function registerType(name : String) : Int;
	@:pure(inferredPure) static function typeId(name : String) : Null<Int>;
	@:pure(inferredPure) static function typeName(id : Int) : String;
}
