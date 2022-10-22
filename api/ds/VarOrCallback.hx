package rflib.common.ds;

extern enum VarOrCallback<T> {
	variable(v : T);
	callback(cb : () -> T);
}
