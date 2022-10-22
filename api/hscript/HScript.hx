package rflib.common.hscript;

extern class HScript {
	private var expr : Expr;
	@:pure(inferredPure) private function new() : Void;
	function exec() : Dynamic;
	static function fromFile(path : rflib.common.Str) : HScript;
	static function fromString(script : rflib.common.Str) : HScript;
}
