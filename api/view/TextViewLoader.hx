package rflib.common.view;

extern class TextViewLoader {
	var tree : rflib.common.Tree;
	private var views_cache : Map<String,rflib.common.TextView>;
	function new(?tree : rflib.common.Tree) : Void;
	function loadViewByClass(cls : Class<rflib.common.TextView>, ?template_name : String) : rflib.common.TextView;
}
