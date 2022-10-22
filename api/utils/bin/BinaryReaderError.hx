package rflib.common.utils.bin;

extern enum BinaryReaderError {
	enum_not_found(ename : String);
	enum_constructor(ename : String, ec : String, params : Array<Dynamic>);
	enum_params(ename : String, ec : String, params : Array<Dynamic>);
	class_not_found(cname : String);
	invalid_hash;
	magic_id;
	wrong_size;
	input_data_truncated;
}
