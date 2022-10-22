package rflib.common.context;

extern class AbstractObject<EXT> {
	private var extensions : Map<AbstractContext,EXT>;
	@:pure(inferredPure) function new() : Void;
	function extendToContext(context : AbstractContext) : EXT;
	@:pure(inferredPure) function getContextExtension(context : AbstractContext) : EXT;
	function onContext(context : AbstractContext) : Void;
}
