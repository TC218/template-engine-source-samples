package rflib.common.hscript._HScriptDataWriter;

extern class rflib.common.hscript.priv_HScriptDataWriter.FieldMeta {
	var key : String;
	var meta : Dynamic;
	@:pure(inferredPure) function new(key : String, meta : Dynamic) : Void;
}
