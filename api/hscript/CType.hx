package rflib.common.hscript;

extern enum CType {
	CTPath(path : Array<String>, ?params : Array<CType>);
	CTFun(args : Array<CType>, ret : CType);
	CTAnon(fields : Array<{t : CType, name : String}>);
	CTParent(t : CType);
}
