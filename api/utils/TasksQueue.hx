package rflib.common.utils;

extern class TasksQueue {
	var events : rflib.common.EventsChannel;
	var first_task : Task;
	private var head_pos : Float;
	private var task_i : Int;
	private var task_width : Float;
	@:pure(inferredPure) function new() : Void;
	function addMultipleTasks(a : Array<Task>) : Void;
	function addTask(t : Task) : Task;
	function clear() : Void;
	function execTasks(async : Null<Bool> = false) : Void;
	function finishTask(t : Task) : Void;
	function resetProgress() : Void;
	function startTask(t : Task) : Void;
	function updateTaskDesc(t : Task) : Void;
	function updateTaskProgress(t : Task) : Void;
	static var SET_DESC : Int;
	static var SET_PROGRESS : Int;
}
