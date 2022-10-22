package rflib.common.sys;

extern class ANSI {
	static var BELL(inline,never) : String;
	private static var COLORTERM : String;
	static var CSI(inline,never) : String;
	static var ESCAPE(inline,never) : String;
	static var attr : Enum<rflib.common.sys.Attribute>;
	private static var is_mate_terminal : Bool;
	private static var step5(inline,never) : Float;
	private static var values : Map<Attribute,Int>;
	static function attrib(attribute : Attribute) : String;
	static function attribs(attributes : Array<Attribute>) : String;
	@:pure(inferredPure) static function bg256(i : Int) : String;
	static function bgColorStr(c : Int, s : String) : String;
	@:pure(inferredPure) static function bgRgb(c : Int) : String;
	static function colorStr(c : Int, s : String) : String;
	@:pure(inferredPure) static function deleteChar() : String;
	@:pure(inferredPure) static function deleteChars(n : Int) : String;
	@:pure(inferredPure) static function deleteLine() : String;
	@:pure(inferredPure) static function deleteLines(n : Int) : String;
	@:pure(inferredPure) static function eraseChar() : String;
	@:pure(inferredPure) static function eraseChars(n : Int) : String;
	@:pure(inferredPure) static function eraseDisplay() : String;
	@:pure(inferredPure) static function eraseDisplayToCursor() : String;
	@:pure(inferredPure) static function eraseDisplayToEnd() : String;
	@:pure(inferredPure) static function eraseLine() : String;
	@:pure(inferredPure) static function eraseLineToCursor() : String;
	@:pure(inferredPure) static function eraseLineToEnd() : String;
	@:pure(inferredPure) static function fg256(i : Int) : String;
	@:pure(inferredPure) static function hideCursor() : String;
	@:pure(inferredPure) static function insertChar() : String;
	@:pure(inferredPure) static function insertChars(n : Int) : String;
	@:pure(inferredPure) static function insertLine() : String;
	@:pure(inferredPure) static function insertLines(n : Int) : String;
	@:pure(inferredPure) static function loadCursor() : String;
	@:pure(inferredPure) static function moveDown(n : Int) : String;
	@:pure(inferredPure) static function moveDownReset(n : Int) : String;
	@:pure(inferredPure) static function moveLeft(n : Int) : String;
	@:pure(inferredPure) static function moveRight(n : Int) : String;
	@:pure(inferredPure) static function moveUp(n : Int) : String;
	@:pure(inferredPure) static function moveUpReset(n : Int) : String;
	@:pure(inferredPure) static function reset() : String;
	@:pure(inferredPure) static function resetY(n : Int) : String;
	@:pure(inferredPure) static function rgb(c : Int) : String;
	@:pure(inferredPure) static function rgb256(r : Int, g : Int, b : Int) : Int;
	@:pure(inferredPure) static function saveCursor() : String;
	@:pure(inferredPure) static function setCursorPos(line : Int, column : Int) : String;
	@:pure(inferredPure) static function setX(n : Int) : String;
	@:pure(inferredPure) static function setY(n : Int) : String;
	@:pure(inferredPure) static function showCursor() : String;
}