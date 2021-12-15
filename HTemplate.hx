package rflib.common.htemplate;

import haxe.ds.StringMap.StringMap;
import haxe.Json;

import rflib.common.Imports;
import rflib.common.hscript.Interp;
import rflib.common.hscript.Interp.InterpContext;
import rflib.common.hscript.Expr;
import rflib.common.htemplate.tag.*;

using Lambda;
using StringTools;



typedef HTemplateContext = 
{
  var interp: Interp;
  var interps: Array<Interp>;
  var interp_context: InterpContext;
  var enable_taghandlers_init_on_phase: Int;
  
  var getTagHandlerClass : (String -> Class<TagHandler>);
  var captureOutput : ((Void -> Void) -> String);
  var startExprTag : (Void -> Void);
  var finishExprTag : (Dynamic -> Dynamic);
  
  @:optional var onTagHandlerInit : (HTemplate -> TagHandler -> Void);
  @:optional var onChildrenInit : (HTemplate -> TagHandler -> Void);  
}


@:allow(rflib.common.htemplate.TagHandler)
class HTemplate
{
  public var nodes : Array<MarkupNode>;
  public var selector : MarkupNodeSelector;
  public var owner : Dynamic;  
  public var context : HTemplateContext;  
  
  public static var hscript_error_index : Int;
  
  
  public function new(nodes:Array<MarkupNode>)
  {
    this.nodes = nodes;
        
    selector = new MarkupNodeSelector(nodes);
  }

  
  public function init()
  {
    if (context.enable_taghandlers_init_on_phase == 0) {
      initTags(nodes);      
    }    
  }
    
  
  function initTagHandlerByName(name:String, node:MarkupNode):TagHandler
  {
    if (name == null) return null;
    
    var tag_handler:TagHandler = null;
    
    var handler_class = context.getTagHandlerClass(name);
    if (handler_class != null && TypeUtils.hasClass(handler_class, TagHandler) )
    {
      tag_handler = Type.createInstance(handler_class, [node, this]);
      
      if (context.onTagHandlerInit != null) {
        context.onTagHandlerInit(this, tag_handler);          
      }
    }
    
    return tag_handler;
  }

  
  function initTags(ns:Array<MarkupNode>)
  {
    if (context.enable_taghandlers_init_on_phase > 0) return;
    
    for (n in ns)
    {      
      var handler:TagHandler = null;
      
      if (n.name != null) 
      {      
        handler = initTagHandlerByName(n.name, n);
        n.handler = handler;
      }
      
      
      if (handler == null) {                
        initTags(n.children);               
      }
      else if (context.onChildrenInit != null) {  
        context.onChildrenInit(this, handler);
      }
    }
  }
  
  
  public function setContext()
  {
    var ic = context.interp_context;
    context.interp.context = ic;
    
    for (i in context.interps)
    {
      i.context = ic;
    }
  }
  
  
  public function exec(?nodes_arg:Array<MarkupNode>)
  {
    setContext();

    var nodes_list = (nodes_arg != null) ? nodes_arg : this.nodes;    
    for (n in nodes_list)
    {
      execSingleNode(n);
    }    
    
  }
  
  
	function execSingleNode(n:MarkupNode, ?vars:Dynamic)
	{
    var handler:TagHandler = null;
    
    if (n.name != null)
    {
      if (context.enable_taghandlers_init_on_phase > 0) {
        handler = initTagHandlerByName(n.name, n);
      }
      else if (n.handler != null && TypeUtils.hasClass(Type.getClass(n.handler), TagHandler)) {
        handler = cast(n.handler, TagHandler);
      }
             
             
      if (handler != null)
      {
        handler.context(function()
        {
          handler.exec();
        });

        setContext();
        return;
      }      
    }


    for (ch in n.children)
    {
      execSingleNode(ch, vars);
    }
  }
  
  
  
	public function output(?nodes_arg:Array<MarkupNode>):String
	{    
    if (context == null) throw 'HTemplateContext not set!';
            
    setContext();
    
    var nodes_list = (nodes_arg != null) ? nodes_arg : this.nodes;
    
/*
    var tag_handlers:Array<TagHandler> = null;

    if (context.enable_taghandlers_init_on_phase > 0) 
    {    
      for (n in nodes_list)
      {
        if (n.name != null)
        {
          var handler = initTagHandlerByName(n.name, n);
                    
          if (tag_handlers == null) tag_handlers = [];
          tag_handlers.push(handler);
        }
      }
      
      if (tag_handlers != null) 
      {
        //for (h in tag_handlers) h.exec();        
        //setContext();
      }
    }
    */
    
    var h_ptr = 0;
		var s = '';
		for (n in nodes_list)
		{
      var handler:TagHandler = null;
            
      if (n.name != null)
      {        
        if (context.enable_taghandlers_init_on_phase > 0) 
        {          
          handler = initTagHandlerByName(n.name, n);
          //handler = tag_handlers[h_ptr++];
        }
        else if (n.handler != null && TypeUtils.hasClass(Type.getClass(n.handler), TagHandler)) {
          handler = cast(n.handler, TagHandler);
        }
        
        if (handler != null)
        {  
          var result:String = null;
               
          handler.context(function()
          {
            result = handler.output();     
          });
          
          if (context.onChildrenInit != null) {
            context.onChildrenInit(this, handler);
          }
          
          setContext();                     
          
          if (handler.trim_line_before)
          {
            var p = s.length-1;
            var c : Int;
            
            do
            {
              c = s.charCodeAt(p);              
              p--;
            } while (c == '\t'.code || c == ' '.code);
            
            p++;
            if (p < s.length-1) s = s.substr(0, p+1);
          }
          
          s += result != null ? result : '';
          
          continue; 
        }
      }

      var result = outputSingleNode(n); 
      
			s += result;
		}

		return s;
	}
  
	function outputSingleNode(n:MarkupNode):String
	{ 
		var s = '';		
    var expr_tags = n.data.exprs;
              
    
		if (n.name == null)
		{
      //if (StringUtils.condenseWhitespace(n.text) == ' ' && n.next != null) return '';
      
			if (n.is_special) s += MarkupParser.l_bracket;
      
//      if (expr_tags != null && expr_tags.text != null)
//        log('eval text: ' + n.text);
        
      s += fillExprTags(n.text, (expr_tags != null) ? expr_tags.text : null);
      
			if (n.is_special) s += MarkupParser.r_bracket;
			return s;
		}
		
		var a = '';			    
    
    if (n.data != null && Std.is(n.data.expr, String)) {
      a = ':' + n.data.expr;
    }
    else for (k in n.attribs.keys())
		{
			a += ' '+k+'="'+fillExprTags(
        n.attribs.get(k), 
        (expr_tags != null) ? expr_tags.attribs.get(Base.strings.getIndex(k)) : null
      )+'"';
		}
		
		s += MarkupParser.l_bracket + n.name + a;
		if (!n.is_open && n.children.length == 0) s += '/';
		s += MarkupParser.r_bracket;
		
		if (n.is_open || n.children.length > 0)
		{
			for (ch in n.children)
			{
				s += outputSingleNode(ch);
			}
			s += MarkupParser.l_bracket + '/'+n.name+ MarkupParser.r_bracket;
		}
		
		return s;
	}


  static var spc_r = new EReg('^(\\s*)(\\S*)(\\s*)$', '');
  
  function formattedTrim(s:String):String
  {
    var r = spc_r;
        
    if (r.match(s))
    {
      var spc_left = (r.matched(1).indexOf('\n') >= 0) ? '\n' : 
        (r.matched(1).length > 0) ? ' ' : '';
        
      var spc_right = (r.matched(3).indexOf('\n') >= 0) ? '\n' : 
        (r.matched(3).length > 0) ? ' ' : '';
      
      return spc_left + r.matched(2) + spc_right;
    }
    else {
      return s;
    }
    
  }
  
  
  
  
  public function fillMapExprs(expr_tags:MapExprTags, map:Map<String, Dynamic>):Map<String, Dynamic>
  {
    var result = new Map<String, Dynamic>();
    for (k in map.keys())
    {
      result.set(k, fillExprTags(
        map[k], 
        (expr_tags != null) ? expr_tags.get(Base.strings.getIndex(k)) : null
      ));
    }
    
    return result;
  }
  
  
	public function fillExprTags(text:String, tags:Array<ExprTag>):Dynamic
	{
    if (tags == null) return text;

		var out = '';    
		var pos = 0;
    
    var return_dynamic_val:Bool = (tags.length == 1 && tags[0].exprs.length == 1 && tags[0].pos == 0 && tags[0].len == text.length);
    
    for (et in tags)
    {      
      var et_output = '';
      var success = false;
      var prev_result:Dynamic = null;
      
      context.startExprTag();

      for (expr in et.exprs)
      {
        try 
        {        
          var result:Dynamic = null;
          
          var outbuf = context.captureOutput(function()
          { 
            result = context.interp.execute(expr);
            
            if (Reflect.isFunction(result)) 
            {
              var fn:Dynamic -> Dynamic = cast result;
              result = fn(prev_result);
            }            
                                    
          });
          
          if (!et.is_silent && return_dynamic_val) {
            return result;
          }
          
          if (!et.is_silent) {
            et_output += outbuf;          
          }
                    
          prev_result = result;
          success = true;
        }
        catch (e:Dynamic) 
        {
          throw e;
          //throw 'hscript: ' + e;
          //untyped __js__('debugger');
          //throw e;
          
          var i = ++hscript_error_index;
          
          //logError(text+'\n'+ 'hscript (${i}): ' + e);
          //out += text.substr(pos, et.pos + et.len - pos);
          out += '[hscript error ${i}]';
          
          success = false;
          break;
        }        
      }
      
      if (success) 
      {
        if (!et.is_silent && prev_result != null) {
          et_output += context.finishExprTag(prev_result);
        }                  
        
        out += text.substr(pos, et.pos - pos);
        
        if (!et.is_silent) {
           out += et_output;
        }
      }
      
      pos = et.pos + et.len;
    }
    				
		if (pos < text.length) {      
			out += text.substr(pos);
    }
		
		return out;
	}
  
  
  public static function getDefaultTagHandlersMap():Map<String, Class<TagHandler>>
  {
    var map : Map<String, Class<TagHandler>> =
    [
      'var' => VarTag,
      'filter' => FilterTag
    ];
    
    return map;
  }

  
  public static function getDefaultContext(?vars:Dynamic):HTemplateContext
  {
    if (vars == null) vars = {};
    
    var outbuf_stack = new Array<String>();
    var is_silent = false;
    var default_tag_handlers = getDefaultTagHandlersMap();
    
    return
    {
      interp: new Interp(),
      interps: new Array<Interp>(),
      interp_context: 
      {
        set: function(k:String, val:Dynamic):Dynamic
        {
          Ref.setField(vars, k, val);
          return val;
        },
        
        get: function(k:String):Dynamic
        {
          return Ref.field(vars, k);
        },
        
        exists: function(k:String):Bool
        {
          return Ref.hasField(vars, k);
        }

      },
      
      enable_taghandlers_init_on_phase: 0,
      
      getTagHandlerClass: function(name:String):Class<TagHandler>
      {
        if (default_tag_handlers.exists(name)) return default_tag_handlers[name];
        else return null;
      },
      
      captureOutput: function(cb:Void -> Void):String
      {
        outbuf_stack.push('');    
        
        cb();    
        
        return outbuf_stack.pop();
      },
      
      startExprTag: function() { is_silent = false; return; },      
      finishExprTag: function(val:Dynamic):Dynamic 
      { 
        if (is_silent) return '';        
        else return val;
      },      
      
    }    
  }
  
  
  
}


class VarTag extends TagHandler
{
  var name : String;
  
  override function get_trim_line_before() return true;
  
  override function init()
  {    
    htemplate.initTags(node.children);    
    
    switch (node.data.expr_expr)
    {
      case EBlock(a):
        switch (a[0])
        {
          case EIdent(name): this.name = name;
          default:
        }
        
      default:
    }

  }
  
  override public function output():String
  {        
    if (name == null) return '';
    
    htemplate.context.interp_context.set(name, htemplate.output(node.children));
    
    return '';
  }
  
}


  /*
  var nodes = HTemplateAssetLoader.loadTemplate(new FileAssetPointer('f.ht'));
  var t = new HTemplate(nodes);
  
  t.context = HTemplate.getDefaultContext(vars);
  
  t.init();
  t.exec();
  var s = t.output();*/
