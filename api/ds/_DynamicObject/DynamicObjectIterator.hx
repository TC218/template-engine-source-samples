package rflib.common.ds._DynamicObject;

extern class rflib.common.ds.priv_DynamicObject.DynamicObjectIterator {
	private var keys : Array<String>;
	private var obj : rflib.common.ds.DynamicObject<Dynamic>;
	private var pos : Int;
	function new(obj : rflib.common.ds.DynamicObject<Dynamic>) : Void;
	function hasNext() : Bool;
	function next() : Dynamic;
}
