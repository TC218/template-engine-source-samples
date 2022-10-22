package rflib.common.hscript;

extern enum ErrorDef {
	EInvalidChar(c : Int);
	EUnexpected(s : String);
	EUnterminatedString;
	EUnterminatedComment;
	EUnknownVariable(v : String);
	EInvalidIterator(v : String);
	EInvalidOp(op : String);
	EInvalidAccess(f : String);
}
