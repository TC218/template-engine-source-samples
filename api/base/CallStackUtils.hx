package rflib.common.base;

extern class CallStackUtils {
	private static function itemToString(b : StringBuf, s : haxe.StackItem) : Void;
	static function printStack(t : StackType, n : Null<Int> = 0, indent : Null<Int> = 0) : String;
	static function stackToString(stack : Array<haxe.StackItem>) : String;
}
