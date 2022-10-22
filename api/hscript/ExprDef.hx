package rflib.common.hscript;

extern enum ExprDef {
	EConst(c : Const);
	EIdent(v : String);
	EVar(n : String, ?t : CType, ?e : Expr);
	EParent(e : Expr);
	EBlock(e : Array<Expr>);
	EField(e : Expr, f : String);
	EBinop(op : String, e1 : Expr, e2 : Expr);
	EUnop(op : String, prefix : Bool, e : Expr);
	ECall(e : Expr, params : Array<Expr>);
	EIf(cond : Expr, e1 : Expr, ?e2 : Expr);
	EWhile(cond : Expr, e : Expr);
	EFor(v : String, it : Expr, e : Expr);
	EBreak;
	EContinue;
	EFunction(args : Array<Argument>, e : Expr, ?name : String, ?ret : CType);
	EReturn(?e : Expr);
	EArray(e : Expr, index : Expr);
	EArrayDecl(e : Array<Expr>);
	ENew(cl : String, params : Array<Expr>);
	EThrow(e : Expr);
	ETry(e : Expr, v : String, t : Null<CType>, ecatch : Expr);
	EObject(fl : Array<{name : String, e : Expr}>);
	ETernary(cond : Expr, e1 : Expr, e2 : Expr);
	ESwitch(e : Expr, cases : Array<{values : Array<Expr>, expr : Expr}>, ?defaultExpr : Expr);
	EDoWhile(cond : Expr, e : Expr);
}
