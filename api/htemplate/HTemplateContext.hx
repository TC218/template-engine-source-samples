package rflib.common.htemplate;

typedef HTemplateContext = {startExprTag : () -> Void, onTagHandlerInit : Null<HTemplate -> rflib.common.TagHandler -> Void>, onChildrenInit : Null<HTemplate -> rflib.common.TagHandler -> Void>, interps : Array<rflib.common.hscript.Interp>, interp_context : rflib.common.hscript.InterpContext, interp : rflib.common.hscript.Interp, getTagHandlerClass : String -> Class<rflib.common.TagHandler>, finishExprTag : Dynamic -> Dynamic, enable_taghandlers_init_on_phase : Int, captureOutput : (() -> Void) -> String}
