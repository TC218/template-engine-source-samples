package rflib.common.utils;

extern class ERegUtils {
	static function matchSubPos(r : EReg, s : rflib.common.Str, p : Int) : Int;
	static function matchSubPosFromEnd(r : EReg, s : rflib.common.Str, p : Int) : Int;
	static function matchSubPosFromEndP(r : EReg, s : rflib.common.Str, p : Int) : Int;
	static function matchSubPosP(r : EReg, s : rflib.common.Str, p : Int) : Int;
	static function matchedEndPos(r : EReg) : Int;
}
