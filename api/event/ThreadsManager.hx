package rflib.common.event;

extern class ThreadsManager {
	static var EVENT : Int;
	private static var _threads : Map<rflib.common.ThreadHandleId,AbstractThread>;
	static var main_thread : AbstractThread;
	private static var mutex : rflib.common.Mutex;
	private static var threads_counter : Int;
	private static var threads_handles : Array<rflib.common.ThreadHandle>;
	static function count() : Int;
	static function create(cb : () -> Void) : AbstractThread;
	static function current() : AbstractThread;
	static function dispatchSingleThreadEvent(e : rflib.common.Event) : Void;
	@:pure(inferredPure) private static function getThreadHandle(t : rflib.common.Thread) : rflib.common.ThreadHandle;
	private static function getThreadHandleId(t : rflib.common.Thread) : rflib.common.ThreadHandleId;
	static function init() : Void;
	static function threadEventsDispatchLoop() : Void;
	static function threads() : Array<AbstractThread>;
}
