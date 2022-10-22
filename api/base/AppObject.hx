package rflib.common.base;

@:build(rflib.common.macro.BuildMacros.buildClass()) @:autoBuild(rflib.common.macro.BuildMacros.buildClass()) @:expose @:allow(rflib.common.base.TreeAppObject) extern class AppObject extends ClassBase {
	private var extensions : rflib.common.ObjectMap<rflib.common.Dyn>;
	var on_children_cbs : rflib.common.VoidCallbackList;
	var on_parent_cbs : rflib.common.VoidCallbackList;
	var tree_object : TreeAppObject;
	function new() : Void;
	function addChild<T>(ch : T) : T;
	function addExtension(ext : rflib.common.Dyn) : Void;
	private function createTreeAppObject() : TreeAppObject;
	function getExtensions<T>(cls : Class<T>) : rflib.common.Arr<T>;
	function hasExtension<T>(cls : Class<T>) : Bool;
	private function init() : Void;
	function label() : String;
	private function matchFilter(obj : AppObject, filter : AppObjectFilter<AppObject>) : Bool;
	function onChildren() : Void;
	function onChildrenCb(cb : rflib.common.VoidCallback) : Void;
	private function onParent() : Void;
	function onParentCb(cb : rflib.common.VoidCallback) : Void;
	function onReceiveFromOutside(event_type_id : rflib.common.EventId, listen_cb : rflib.common.ObjEvent -> rflib.common.Listener -> Void) : Void;
	function queryChildren<T>(?filter : AppObjectFilter<T>, ?traverse_filter : AppObjectFilter<AppObject>, limit : Null<Int> = 0, cb : Null<T -> Bool> = null, include_self : Null<Bool> = false, ?options : AppObjectQueryOptions) : Array<T>;
	function queryParents<T>(?filter : AppObjectFilter<T>, limit : Null<Int> = 0, cb : Null<T -> Bool> = null, include_self : Null<Bool> = false) : Array<T>;
	function toString() : String;
	static function getAs<T>(obj : Dynamic, cls : Class<T>) : T;
	static function getTreeAppObject(obj : rflib.common.TreeObject) : AppObject;
}
