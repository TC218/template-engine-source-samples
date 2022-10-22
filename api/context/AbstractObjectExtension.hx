package rflib.common.context;

extern class AbstractObjectExtension {
	var context : AbstractContext;
	var object : AbstractObject<Dynamic>;
	@:pure(inferredPure) function new(object : AbstractObject<Dynamic>, context : AbstractContext) : Void;
}
