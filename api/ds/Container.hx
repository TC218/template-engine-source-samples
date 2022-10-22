package rflib.common.ds;

extern enum Container<T> {
	intMap(map : Map<Int,T>);
	stringMap(map : Map<String,T>);
	objectMap(map : rflib.common.ObjectMap<T>);
	array(a : Array<T>);
	fixedArray(a : rflib.common.FixedArray<T>);
}
