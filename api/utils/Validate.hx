package rflib.common.utils;

extern class Validate {
	static function email(email : String) : Bool;
	@:pure(inferredPure) static function id(segment : String) : Int;
}
