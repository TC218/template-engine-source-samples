package rflib.common.utils;

extern class CallbackList<CBT> {
	private var list : Array<rflib.common.utils.priv_CallbackList.FArgs<CBT>>;
	@:pure(inferredPure) function new() : Void;
	function add(cb : CBT, ?args : Array<Dynamic>) : rflib.common.utils.priv_CallbackList.FArgs<CBT>;
	function exec(?args : Array<Dynamic>, reverse : Null<Bool> = false) : Void;
	function remove(fa : rflib.common.utils.priv_CallbackList.FArgs<CBT>, ?exec_prepend_args : Array<Dynamic>) : Void;
	private static function prepareArgs(?prepend_args : Array<Dynamic>, fa : rflib.common.utils.priv_CallbackList.FArgs<Dynamic>) : Array<Dynamic>;
}
