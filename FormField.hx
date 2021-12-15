package rflib.app.template.tag.html.field;


@:allow(rflib.app.template.tag.html.field.FormFieldTag)

@:build(rflib.app.utils.Macros.initFields({
  BLUR: { id_class: 'event' },
  KEYDOWN: { id_class: 'event' },
  CLOSE: { id_class: 'event' },
  CHANGE: { id_class: 'event' },
  MOUSEDOWN: { id_class: 'event' },
  CLICK: { id_class: 'event' },
  VALUE: { id_class: 'event' },
}))
class FormField extends AppObject
{    
  public var tag : FormFieldTag;
  public var scope : Scope;
  
  public var field_type_id : Id;  
  public var options : Dynamic;
  public var next : FormField;
  
  public var input_filters : FiltersChain;
  public var output_filters : FiltersChain;
  public var view_filters : FiltersChain;
    
  public var errors : Dynamic;
  
  public var attribs(get, set) : MarkupAttribs;
  inline function get_attribs():MarkupAttribs return tag.attribs;
  inline function set_attribs(v:MarkupAttribs):MarkupAttribs return tag.attribs = v;
  
  var skip_default_filters : Bool;
  
  var default_val : Dynamic;
  
  public var has_value(get, never) : Bool;
  function get_has_value():Bool return true;
  
  function isFilterAllowed(name:String):Bool return true;

  
  function onAttribs(v:MarkupAttribs)
  {
    var init_default_input_filters = false;
    
    if (v.exists('options') && Reflect.isObject(v['options'])) 
    {
      options = v['options'];  
      
      if (options.filters != null)
      {        
        if (!skip_default_filters &&
            !Filter.fdefHasFilter(options.filters, 'string.condenseSpace') &&
            !Filter.fdefHasFilter(options.filters, 'no-string.condenseSpace') &&
            isFilterAllowed('string.condenseSpace')
        )            
        {
          if (!Std.is(options.filters, Array)) {
            options.filters = [options.filters];
          }
          
          options.filters.unshift('string.condenseSpace');
        }
        
        input_filters = SharedBase.filters_registry.createFilters(options.filters);                
        //log(input_filters);
      } 
      else {
        init_default_input_filters = true;
      }   
            
      if (options.out_filters != null) {
        output_filters = SharedBase.filters_registry.createFilters(options.out_filters);        
      }    
      
      if (options.view_filters != null) {
        view_filters = SharedBase.filters_registry.createFilters(options.view_filters);        
      }    
      
    }
    else 
    {
      options = {};      
      init_default_input_filters = true;
    }

    
    if (!skip_default_filters && init_default_input_filters) 
    {
      var a:Array<Dynamic> = [];
      
      if (isFilterAllowed('string.condenseSpace')) {
        a.push('string.condenseSpace');
      }
      
      input_filters = SharedBase.filters_registry.createFilters(a);              
    }

    onFilters();
    
    if (input_filters != null)
    {
      input_filters.validate = true;        
      input_filters.smart_parse = true;
    }
    
    return v;
  }  
    
  
  public var name(get, never) : String;
  inline function get_name():String return attribs['name'];

  
  public var required(get, never):Bool;
  function get_required():Bool return (input_filters != null) ? input_filters.required : false;

  
  public function new(tag:FormFieldTag)
  {
    super();
    
    this.tag = tag;
    
    scope = new Scope();
    scope.set('_field', this);    
    
    init();
  }
  
  function init()
  {
  }
  
  function onFilters()
  {
  }
  
  public function isEventSupported(e:EventId):Bool
  {
    return false;
  }
  
  public function output():String
  {
    return null;
  }
  
  
  var _val : Dynamic;
  
  function setDirectViewValue(val:Dynamic, ?has_error:Bool=false):Dynamic
  {
    if (!has_error) onCleanViewValue(val);
    return val;
  }
  
  function onCleanViewValue(val:Dynamic)
  {
  }
  
  public var internal_val(get, set):Dynamic;
  function get_internal_val():Dynamic return (_val == null) ? '' : _val;
  function set_internal_val(v:Dynamic):Dynamic 
  {
    clearErrors();
    
    _val = v;   
    setDirectViewValue(applyViewFilters(v), false);
    new ObjEvent(VALUE).send(tree_object); 
    
    return v;
  }

  public var view_val(get, set):Dynamic;
  function get_view_val():Dynamic return null;
  function set_view_val(v:Dynamic):Dynamic 
  {
    var val = applyInputFilters(v);

    if (errors == null) {
      set_internal_val(val);    
    }
    else {
      setDirectViewValue(val, true);
    }
    
    return v;
  }


  public var val(get, set):Dynamic;
  function get_val():Dynamic 
  {
    return applyOutputFilters(_val);
  }

  function set_val(v:Dynamic):Dynamic 
  {
    var val = applyInputFilters(v);
    
    if (errors == null) {
      set_internal_val(val);    
    }
    else {  
      setDirectViewValue(val, true);
    }
    
    return v;    
  }
    

  public var container_val(get, set):Dynamic;
  function get_container_val():Dynamic 
  {
    return applyOutputFilters(_val);
  }

  function set_container_val(v:Dynamic):Dynamic 
  {
    var val = applyInputFilters(v);
    
    if (errors == null) {
      set_internal_val(val);    
    }
    else {  
      setDirectViewValue(val, true);
    }
    
    return v;    
  }

  
  public var field_id(get, never):String;
  function get_field_id():String return SharedBase.getIndexString(field_type_id) + '-' + tree_object.id;

    
  function getHtmlAttribs():MarkupAttribs
  {    
    var h_attribs = HtmlView.extractHtmlAttribs(attribs);        
    
    return h_attribs;
  }
  
  
  public function focus()
  {
  }

  public function open()
  {
  }

  public function close()
  {
  }

  public function reset()
  {
    if (attribs.exists('value')) {
      view_val = attribs['value'];
      //internal_val = attribs['value'];
    }
    else 
    {    
      var v:Dynamic = DS.deepClone(      
        (options.default_val != null) ? options.default_val :
          (input_filters != null) ? input_filters.default_val : default_val
        );
          
      internal_val = v;
    }
  }
  
  public function onHtmlAttach()
  {
  }

  public function onBeforeHtmlDetach()
  {
  }
    
  public function addListener(event_type_id:EventId, cb:Dynamic -> Void)
  {    
  }
  
  public function removeListener(event_type_id:EventId, cb:Dynamic -> Void)
  {    
  }
  
  
  public var element(get, never):Dynamic;
  function get_element():Dynamic return null;
  
  
  public inline function _(s:Dynamic):Dynamic return new JQuery(s);
 
 
  public function setError(code:String, msg:String)
  {
    if (errors == null) errors = {};
    Reflect.setField(errors, code, msg);
  }


  public function clearError(code:String)
  {
    if (errors != null)
    {
      Reflect.deleteField(errors, code);
      
      if (Reflect.fields(errors).length == 0) {
        clearErrors();
      }
    }
  }

  
  public function applyInputFilters(val:String):String
  {
    var v = val;
    
    if (input_filters != null)
    {      
      try 
      {
        v = input_filters.process(v);     
        clearErrors();                   
      }
      catch (e:FilterException)
      {
        errors = {};
        setError(e.code, e.msg);  
        
        //SharedBase.error(e);
        showErrors();
        
        v = e.val;
      }      
    }    
    
    return v;
  }
  
  
  public function applyOutputFilters(val:Dynamic):Dynamic
  {
    try {
      return (output_filters != null) ? output_filters.process(val) : val;
    }
    catch (e:FilterException) {
      return null;
    }
  }


  public function applyViewFilters(val:String):String
  {
    try {
      return (view_filters != null) ? view_filters.process(val) : val;
    }
    catch (e:FilterException) {
      return '';
    }
  }


  public function parseView(val:Dynamic):Dynamic
  {
    try 
    {
      val = input_filters.process(val); 
      return applyViewFilters(val);          
    }
    catch (e:FilterException) null;
        
    return null;
  }
  
  
  public function clearErrors()
  {
    errors = null;
  }
  
  public function showErrors()
  {
  }

  public function hideErrors()
  {
  }
  
}


