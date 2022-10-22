package rflib.common.context;

extern class AbstractContext {
	private var contexts_extensions_map : haxe.ds.ObjectMap<Dynamic,Class<AbstractObjectExtension>>;
	@:pure(inferredPure) function new() : Void;
	private function addExt(obj : Class<AbstractObject<Dynamic>>, ext : Class<AbstractObjectExtension>) : Void;
	function getExtensionFor(obj : AbstractObject<Dynamic>) : AbstractObjectExtension;
}
