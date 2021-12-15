package rflib.common.view;


import rflib.common.hscript.Interp;
import rflib.common.hscript.Parser;

using StringTools;


//typedef TextViewValue = { val: Dynamic }
/*
enum TextViewValue
{
  v(val:Dynamic);
}*/

class TextViewValue
{
  public var val:Dynamic;
  
  public function new(val:Dynamic) this.val = val;
}


typedef TextViewVars = Map<Id, TextViewValue>
typedef TagHandlersMap = Map<Id, Class<TagHandler> >;


@:allow(rflib.common.view.TextView)
@:allow(rflib.common.view.TextViewTagHandler)
class TextViewContext
{  
  static var _id_counter : Int = 1;
  
  var _htcontext : HTemplateContext;
  public var htcontext(get, never) : HTemplateContext;
 
  var interp : Interp;
  
  public var app_objects_stack : Array<AppObject>;
  public var vars_stack : Array<TextViewVars>;
  public var vars_cache_stack : Array<TextViewVars>;
  public var tag_handlers_map_stack : Array<TagHandlersMap>;  
  public var tag_handlers_stack : Array<TagHandler>;  
  
  public var outbuf_stack : Array<String>;

  var id_gen_groups:Map<Id, Int>;  
  
  var _id : Int;
  public var id(get, never) : Int;
  public inline function get_id():Int return _id;
  
  //var loader : HTemplateLoader2;
  
  
  public function new()
  {
    interp = new Interp();    
    
    app_objects_stack = [];    
    vars_stack = [];  
    vars_cache_stack = [];
    tag_handlers_map_stack = []; 
    tag_handlers_stack = [];
    
    outbuf_stack = [];
    
    id_gen_groups = new Map<Id, Int>();    
    _id = _id_counter++;    
    
    //loader = new HTemplateLoader2();
  }
  
  
  public inline function print(s:String)
  {
    outbuf_stack[outbuf_stack.length-1] += s;
  }
  
  
  public function captureOutput(cb:Void -> Void):String
  {
    outbuf_stack.push('');    
    
    cb();    
    
    return outbuf_stack.pop();
  }

  
  public inline function scope(cb:Void -> Void, ?map:TextViewVars)
  {
    vars_stack.push((map != null) ? map : new TextViewVars());
    vars_cache_stack.push(new TextViewVars());
    
    cb();
    
    vars_cache_stack.pop();
    vars_stack.pop();
  }


  public function handlersMapContext(handlers:Map<String, Class<TagHandler>>, cb:Void -> Void)
  {
    var map = new TagHandlersMap();
    for (k in handlers.keys())
    {
      map.set(Base.strings.index(k), handlers.get(k) ); 
    }
    tag_handlers_map_stack.push(map);

    cb();
    
    tag_handlers_map_stack.pop();
  }

  


  public inline function hasScope():Bool return (vars_stack.length > 0);
  
  
  public function set(k:String, val:Dynamic):Dynamic
  {
    var id = Base.strings.getIndex(k);
    
    var cmap = vars_cache_stack[vars_cache_stack.length-1];
    if (id != null && cmap.exists(id)) cmap.remove(id);
    
    var vars = vars_stack[vars_stack.length-1];
    if (id != null && vars.exists(id)) {
      vars.get(id).val = val;
    }
    else {
      vars.set(Base.strings.index(k), new TextViewValue(val) /*{ val: val }*/ );
    }
    
    return val;    
  }
        

  public function setExternal(k:String, val:Dynamic):Dynamic
  {
    var id = Base.strings.getIndex(k);
    if (id == null) return null;
        
    var i = vars_stack.length - 2;
    while (i >= 0)
    {
      if (vars_stack[i].exists(id)) {        
        return vars_stack[i].get(id).val = val;
      }
      
      i--;
    }
    
    return val;
  }
        
        
  public function get(k:String):Dynamic
  {
    var id = Base.strings.getIndex(k);
    if (id == null) return null;
    
    var cmap = vars_cache_stack[vars_cache_stack.length-1];
    if (id != null && cmap.exists(id)) return cmap.get(id).val;
    
    var i = vars_stack.length - 1;
    while (i >= 0)
    {
      if (vars_stack[i].exists(id)) 
      {
        var r = vars_stack[i].get(id);
        cmap.set(id, r);
        
        return r.val; 
      }
      
      i--;
    }
    
    return null;
  }  
  
    
  public function exists(k:String, ?look_levels:Int):Bool
  {
    var id = Base.strings.getIndex(k);
    if (id == null) return false;

    var cmap = vars_cache_stack[vars_cache_stack.length-1];
    if (id != null && cmap.exists(id)) return true;
    
    var i = vars_stack.length - 1;
    while (i >= 0)
    {
      if (vars_stack[i].exists(id)) 
      {
        cmap.set(id, vars_stack[i].get(id));                            
        return true;
      }
      
      i--;
      
      if (look_levels != null)
      {
        look_levels--;
        if (look_levels <= 0) break;
      }
    }
    
    return false;
  }
   
   
  function get_htcontext():HTemplateContext
  {
    if (_htcontext != null) return _htcontext;
    
    var default_vars = interp.getDefaultContextVariables();    
    var top_scope = new Scope();
    
    for (k in default_vars.keys())
    {
      top_scope.set(k, default_vars.get(k));
    }    
    
    default_vars = null;    

    //var html_esc = true;
    var is_silent = false;
    var packages_css_prefix = new Map<String, String>();
    
    
    top_scope.setVars(
    {
      Std: Std,
      Reflect: Reflect,
      Ref: Reflect,
      Math: Math,
      
      Array: Array,
      String: String,
      Bool: Bool,
      Int: Int,
      Float: Float,
      
      Path: haxe.io.Path,
      DS: DS,
      clone: DS.deepClone,
      containerValue: function(c:Container<Dynamic>):Dynamic return DS.containerValue(c),
      
      StringMap: haxe.ds.StringMap,
      IntMap: haxe.ds.IntMap,
      ObjectMap: haxe.ds.ObjectMap,
      
      get: get,
      set: set,
      setExternal: setExternal,
      exists: exists,
      macroExists: function(name) return macroExists(name),
      has: function(k) { return exists(k) && get(k) != null; },
      resetMacro: function(name) set('macro_'+name, null),
      
      json: function(obj) { /*html_esc = false;*/ return haxe.Json.stringify(obj); },
      print: function(obj) return print(obj), 
      log: function(v) { log(v); },
      
      noesc: function(obj) { /*html_esc = false; */return obj; },
      esc: function(obj) return StringTools.htmlEscape(''+obj, true),
      silent: function(obj) { is_silent = true; return obj; },
      nl2br: function(obj) { return (''+obj).replace('\n', '<br/>\n'); },
      
      contextId: function() { return _id; },
      //test: function(obj) { this.print('tt'); return '_'+obj+'_'; }
      
      round: function(obj:Dynamic, places:Dynamic)
      {
        if (!Std.is(obj, Float)) {
          obj = Std.parseFloat(''+obj);
        }
        
        if (!Std.is(places, Int)) {
          places = Std.parseInt(''+places);
        }
        
        return MathUtils.roundDecimals(obj, places);
      },
      
      fillzeros: function(obj:Dynamic, places:Dynamic)
      {
        if (!Std.is(obj, Float)) {
          obj = Std.parseFloat(''+obj);
        }
        
        if (!Std.is(places, Int)) {
          places = Std.parseInt(places);
        }
        
        return StringUtils.floatFillZeros(obj, places);
      },
          
      currency: function(obj:Dynamic)
      {
        if (!Std.is(obj, Float)) {
          obj = Std.parseFloat(obj);
        }

        return StringUtils.floatFillZeros(MathUtils.roundDecimals(obj, 2), 2);
      },
      
      callMacro: function(name:String, params:Dynamic, ?return_vars:Array<String>)
      {        
        if (macroExists(name))
        {
          var return_string = false;
          
          if (Std.is(return_vars, Bool)) 
          {
            return_vars = [];
            
            var b:Bool = cast return_vars;
            if (b) return_string = true;
          }
          else if (Std.is(return_vars, String)) {
            return_vars = [cast return_vars];
          }
          
          var result:Dynamic = callMacro(name, params, return_vars);          
          
          if (return_vars != null) {
            return return_string ? result._content : result;
          }
                    
          print(result);
          
          //html_esc = false;  
          is_silent = true;              
        }
        else {
          print('callMacro(): Macro not found: ${name}');
        }        
        
        return null;
      },
      
      createFilters: function createFilters(def:Dynamic) return Base.filters_registry.createFilters(def),
      
      filtersDefinitionHasFilter: Filter.fdefHasFilter,
      fdefHasFilter: Filter.fdefHasFilter,
      
      cssPre: function(?s:String)
      {
        var pkg = Base.packages_contexts.current;
        if (pkg != null)
        {
          if (packages_css_prefix.exists(pkg)) {
            return (s != null) ? packages_css_prefix[pkg] + '_' + s : packages_css_prefix[pkg];
          }
          
          var prefix = pkg.split('.').join('-');
          packages_css_prefix.set(pkg, prefix);
          
          return (s != null) ? prefix + '_' + s : prefix;
        }
        else {
          return s;
        }
        
      }
      
    });
    
    
    vars_stack.push(top_scope.variables);    
    vars_cache_stack.push(new TextViewVars());
    
    
    var default_tag_handlers = TextView.getDefaultTagHandlersMap();
    var handlers = new TagHandlersMap();
    for (k in default_tag_handlers.keys())
    {
      handlers.set(Base.strings.index(k), default_tag_handlers.get(k) ); 
    }
    tag_handlers_map_stack.push(handlers);
   
   
    
    _htcontext = 
    {
      interp: interp,
      interps: [],
      interp_context: 
      {
        get: get,        
        set: set,        
        exists: function(k:String):Bool return exists(k)
      },
      
      enable_taghandlers_init_on_phase: 0,
      
      getTagHandlerClass: function(name:String):Class<TagHandler>
      {
        var id = Base.strings.getIndex(name);
        if (id == null) return null;
        
        var i = tag_handlers_map_stack.length - 1;
        while (i >= 0)
        {
          if (tag_handlers_map_stack[i].exists(id)) return tag_handlers_map_stack[i].get(id);
          i--;
        }
        
        return null;        
      },
      
      captureOutput: captureOutput,
            
      onTagHandlerInit: function(htemplate:HTemplate, tag:TagHandler)
      {
        var view = cast(htemplate.owner, TextView);
        
        if (TypeUtils.hasClass(Type.getClass(tag), AppObjectTagHandler))
        {          
          var obj = cast(tag, AppObjectTagHandler).app_object;
          
          if (obj != null) 
          {
            if (app_objects_stack.length > 0) {   
              app_objects_stack[app_objects_stack.length-1].tree_object.addChild(obj.tree_object);
            }
            else {
              view.tree_object.addChild(obj.tree_object);
            }
            
          }
        } 
        
      },
      
      startExprTag: function() { /*html_esc = true;*/ is_silent = false; return; },      
      finishExprTag: function(val:Dynamic):Dynamic 
      { 
        if (is_silent) return '';
        else return val; //html_esc ? StringTools.htmlEscape(''+val, true).replace('\n', '<br/>\n') : val; 
      },
      
      onChildrenInit: function(htemplate:HTemplate, tag:TagHandler)
      {
        var view = cast(htemplate.owner, TextView);
        
        if (tag == null && (view.tree_object.parent == null || view.tree_object.parent == view.tree_object.tree.root) ) 
        {
          view.onChildren();
          view.on_children_cbs.exec();
        }
        else if (TypeUtils.hasClass(Type.getClass(tag), AppObjectTagHandler))
        {          
          var obj = cast(tag, AppObjectTagHandler).app_object;
          
          if (obj != null) 
          {
            obj.onChildren();
            obj.on_children_cbs.exec();
          }
        } 
        
      }
      
    }
    
    return _htcontext;
  }
  
  
  public function genId(group:String):Int
  {
    var g_id = Base.strings.index(group);
    
    if (!id_gen_groups.exists(g_id)) {
      id_gen_groups[g_id] = 1;
    }
    else {
      id_gen_groups[g_id] += 1;
    }

    return id_gen_groups[g_id];
  }
  
  
  public function snapshot():TextViewContext
  {
    var c = new TextViewContext();
    
    c.get_htcontext();
    c.app_objects_stack = app_objects_stack.copy();
    
    var top_scope = c.vars_stack[0];
    c.vars_stack = vars_stack.copy();
    c.vars_stack[0] = top_scope;
            
    c.tag_handlers_map_stack = tag_handlers_map_stack.copy();
    //c.outbuf_stack = outbuf_stack.copy();
    
    c.id_gen_groups = id_gen_groups;
    
    c.htcontext.interps.push(interp);
    
    return c;
  }
  
  
  public inline function macroExists(name:String):Bool
  {
    var fn = get('macro_'+name);
    return (fn != null && Reflect.isFunction(fn));
  }
  
  
  public function callMacro(name:String, params:Dynamic, ?return_vars:Array<String>):Dynamic
  {
    var fn = get('macro_'+name);
    if (fn != null && Reflect.isFunction(fn)) 
    {
      var result = fn(this, params, return_vars);
      return result;        
    }    
    else {
      throw new HException('Macro not found: ${name}');
    }    
  }
        
        
  public static function dumpVars(va:Array<TextViewVars>):Array<Map<String, Dynamic>>
  {
    var a = new Array<Map<String, Dynamic>>();
    
    for (v in va)
    {
      var m = new Map<String, Dynamic>();
      for (id in v.keys())
      {
        m[Base.strings.getString(id)] = v[id];
      }      
      
      a.push(m);
    }
    
    return a;
  }

        
}

