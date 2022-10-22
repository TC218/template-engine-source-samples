package rflib.common.hscript;

extern enum Token {
	TEof;
	TConst(c : Const);
	TId(s : String);
	TOp(s : String);
	TPOpen;
	TPClose;
	TBrOpen;
	TBrClose;
	TDot;
	TComma;
	TSemicolon;
	TBkOpen;
	TBkClose;
	TQuestion;
	TDoubleDot;
}
