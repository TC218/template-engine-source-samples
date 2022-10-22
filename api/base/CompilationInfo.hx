package rflib.common.base;

extern class CompilationInfo {
	static var types_gen_id_strings : Map<String,Array<String>>;
	static var types_gen_id_strings_rev_map : Map<String,Map<String,rflib.common.Id>>;
	static function getIdString(id_class : String, id : rflib.common.Id) : String;
	static function getStringId(id_class : String, field_path : String) : Null<rflib.common.Id>;
	static function init() : Void;
}
