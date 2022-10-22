package rflib.common.base;

extern enum StackType {
	call;
	exception;
	arg(a : Array<haxe.StackItem>);
}
