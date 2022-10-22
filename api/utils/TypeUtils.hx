package rflib.common.utils;

extern class TypeUtils {
	static function constrainClass(v : rflib.common.Dyn, c : Class<rflib.common.Dyn>) : Void;
	static function createInstance<T>(c : Class<T>, ?args : Array<Dynamic>) : T;
	static function getClassBranch(c : Class<Dynamic>) : Array<Class<Dynamic>>;
	static function getMetaFields(inst : Dynamic, meta_key : String) : rflib.common.DynMap;
	static function hasClass(c : Class<Dynamic>, has : Class<Dynamic>) : Bool;
	static function onEachClass(c : Class<Dynamic>, cb : Class<Dynamic> -> Void) : Void;
}
