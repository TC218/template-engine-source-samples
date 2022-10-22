package rflib.common.utils.markup;

extern class MarkupConfig {
	var l_bracket : rflib.common.Str;
	var r_bracket : rflib.common.Str;
	@:pure(inferredPure) function new(?l_bracket : rflib.common.Str, ?r_bracket : rflib.common.Str) : Void;
}
