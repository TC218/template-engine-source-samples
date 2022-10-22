package rflib.common.ds;

extern class DS {
	static function arrayHasEnumValue(a : Array<EnumValue>, val : EnumValue) : Bool;
	@:pure(inferredPure) static function containerValue(c : Container<Dynamic>) : Dynamic;
	static function copyFields(src : Dynamic, ?dest : Dynamic, filterCb : Null<rflib.common.Str -> Bool> = null) : Dynamic;
	static function copyMapValues(src : Map<String,Dynamic>, dest : Map<String,Dynamic>, ?keys : Array<String>) : Map<String,Dynamic>;
	static function deepClone(v : Dynamic, convert : Null<Dynamic -> Dynamic> = null) : Dynamic;
	static function deepMerge(a : Dynamic, b : Dynamic) : Dynamic;
	static function deeplyCompare(a : Dynamic, b : Dynamic) : Bool;
	static function extractPrefixFields(values : Dynamic, prefix : String) : Dynamic;
	static function forceMap(obj : Dynamic) : rflib.common.StringMap<Dynamic>;
	@:pure(inferredPure) static function isAnyMap(val : Dynamic) : Bool;
	@:pure(inferredPure) static function isMap(val : Dynamic) : Bool;
	static function isMapCompat(obj : Dynamic) : Bool;
	static function isObject(val : Dynamic) : Bool;
	static function objectValues(src : Dynamic, ?keys : Array<String>) : Array<Dynamic>;
	static function removeFields(o : rflib.common.Dyn, keys : rflib.common.Arr<rflib.common.Str>) : Void;
	static function shallowMerge(a : Dynamic, b : Dynamic, ?keys : Array<String>) : Dynamic;
	static function stringMapToDynamic(map : Map<String,Dynamic>) : Dynamic;
}
