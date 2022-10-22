package rflib.common.view;

extern class Scope {
	var variables : rflib.common.TextViewVars;
	@:pure(inferredPure) function new() : Void;
	function exists(k : String) : Bool;
	function get(k : String) : Dynamic;
	function getStringKeysObject() : Dynamic;
	function getVars() : Dynamic;
	function set(k : String, val : Dynamic) : Dynamic;
	function setVars(obj : Dynamic) : Void;
}
