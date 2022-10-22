package rflib.common.base;

extern class Base {
	static var assetsBasePath : rflib.common.Str;
	private static var assets_priv_dir(inline,never) : String;
	static var classes : Array<Dynamic>;
	static var classesMap : rflib.common.ObjectMap<Bool>;
	static var directories_contexts : rflib.common.ContextsStack<String>;
	static var eventsObject : rflib.common.TreeObject;
	static var filters_registry : rflib.common.FiltersRegistry;
	static var packages_contexts : rflib.common.ContextsStack<String>;
	static var strings : rflib.common.StringsRegistry;
	@:pure(inferredPure) static function createAssetPointer(local_path : String, ?path : String) : rflib.common.AssetPointer;
	static function getAssetPath(local_path : String, ?mod_path : String) : String;
	static function getAssetPointer(local_path : String, ?mod_path : String) : rflib.common.AssetPointer;
	static function getClassAssetsPath(c : Class<Dynamic>) : String;
	static function getClassesByBase<T>(base : Class<T>) : rflib.common.Arr<Class<T>>;
}
