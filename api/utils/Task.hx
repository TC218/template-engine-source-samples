package rflib.common.utils;

extern class Task {
	private var _desc : String;
	private var _progress : Float;
	var desc(get,set) : String;
	var exec_cb : Task -> Bool;
	private var i : Int;
	var n_steps : Int;
	var next : Task;
	var on_progress : Task -> Void;
	var progress(get,set) : Float;
	var progress_i(get,set) : Int;
	var queue : TasksQueue;
	var reflect_to : Task;
	function new(desc : String, exec_cb : Task -> Bool, on_progress : Null<Task -> Void> = null) : Void;
	function finish() : Void;
	private function get_desc() : String;
	private function get_progress() : Float;
	private function get_progress_i() : Int;
	private function set_desc(val : String) : String;
	private function set_progress(val : Float) : Float;
	private function set_progress_i(val : Int) : Int;
	function start() : Void;
}
