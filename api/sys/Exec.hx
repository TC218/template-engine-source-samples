package rflib.common.sys;

extern class Exec {
	static var log_commands : Bool;
	static var log_commands_prefix : String;
	static function cmd(cmd : String, ?args : Array<String>, ?stdin : rflib.common.Input, on_buffer : Null<rflib.common.Bytes -> Int -> Void> = null, on_line : Null<String -> Void> = null, log_stdin : Null<Bool> = false, ?options : Dynamic) : Int;
	static function cmdGetAllBytes(command : String, ?args : Array<String>, ?stdin : rflib.common.Input) : rflib.common.Bytes;
	static function cmdGetFirstLine(command : String, ?args : Array<String>, ?stdin : rflib.common.Input) : String;
	static function forceLog(cb : () -> Void, val : Null<Bool> = false) : Void;
	static function osShellCommand(cmd : String, ?args : Array<String>, ?stdin : rflib.common.Input, on_buffer : Null<rflib.common.Bytes -> Int -> Void> = null, on_line : Null<String -> Void> = null, log_stdin : Null<Bool> = false, ?options : Dynamic) : Int;
}
