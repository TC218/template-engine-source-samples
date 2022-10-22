package rflib.common.sys;

extern class CLICommand {
	var cli_main_base : rflib.common.CLIMainBase;
	var help_desc : String;
	var help_syntax : String;
	var names : Array<String>;
	function new(main : rflib.common.CLIMainBase, names : Array<String>, args : String, help_desc : String) : Void;
	function exec(?args : Array<String>) : Void;
	private function helpSyntax(?args : String) : String;
	private function init() : Void;
	function parseSwitch(s : String) : Bool;
	function parseSwitches(a : Array<String>) : Void;
	function resetSwitches() : Void;
}
