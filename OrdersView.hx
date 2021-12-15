package view.orders;


class OrdersView extends TableView
{ 
  public static var template_name : String = 'orders/orders.html';
  
  var allow_edit_clients : Bool = true;
      
  
  public function new()
  {
    model_name = 'Orders';
    
    title = 'Pasūtījumi';
    item_name = 'pasūtījums';
    item_name_multiple = 'pasūtījumi';
    item_is_female = false;
    
    enable_partial_resultset = true;
    
    addExtension(new InfoPopoversExtension(
    [
      { element: 'table.edit thead th:first', content: 'Pele uz ID, un redzams pasūtījuma statuss.', placement2: '5 -4' },
      { element: 'table.edit:first', content: 'Labā peles poga, uz šūnas, dod papildus iespējas.', placement2: 'center 0 -4' }
    ]));


    {
      menu_ext = new TableItemsMenuExtension(this, 
        { cancel: { name: 'Anulēts pasūtījums', type: 'checkbox', selected: true } },
        [ 'cancel' => rowsMenuOnCancel ]
      );
      
      menu_ext.tree_object.listen(TableItemsMenuExtension.SHOW, function(e:ObjEvent, l:Listener)
      {                        
        clearSelection();
        selectItem(e.data.item.fields.id);
        
        e.data.opt.items.cancel.selected = e.data.item.fields.flags.indexOf('canceled') >= 0;      
      });
      
      addExtension(menu_ext);
    }
    
    
    super();

    scope.set('allow_edit_clients', allow_edit_clients);        
    
  }
  
    
  
  override function onOutput()
  {
    filter_form = query({ classs: HtmlForm, fields: { tag_id: 'filter-form' } }, 1)[0];

    super.onOutput();    
    
    filter_form.tree_object.listen(FormAppObject.SUBMIT, function(e:ObjEvent, l:Listener)
      { 
        clearSelection();                  
        clearItems();
        
        //log(e.data);
        
        var list_options = getListOptions();
        _('table.edit').toggleClass('search', list_options.where.length > 0);        
        
        remoteCall('Orders.getList', [list_options], function(result) 
        {            
          addItems(JsHelper.jsToHaxeArray(result.result.result));
        });
        
      }, Listener.SOURCE_OUTPUT
    );      
    
    
    _('#add-test').on('click', function()
    {
      remoteCall('Orders.testAddOrders', [], 
        function(result) 
        {
          log(result);
          
          addItems(JsHelper.jsToHaxeArray(result.result.result));
        }
      ); 

    });
            

    var table_form = query({ classs: HtmlForm, fields: { tag_id: 'table-form' } }, { except: { classs: TableView }}, 1)[0];

    data_bindings = 
    [
      {
        source: { method: 'Drivers.getList', args: variable([Main.inst.models['Drivers'].getListOptions()]) },
        targets: 
        [
          //AppObject.getAs(table_form.fields['driver_id'].tree_object, SelectField)
        ],
        result_var: 'drivers',
        result_var_map: true
      },
      
      {
        source: { method: 'Branches.getList', args: variable([Main.inst.models['Branches'].getListOptions()]) },
        targets: [],
        result_var: 'branches',
        result_var_map: true
      }      
    ];
    
    if (allow_edit_clients)
    {
      data_bindings.push(
      {
        source: { method: 'Clients.getList', args: variable([Main.inst.models['Clients'].getListOptions()]) },
        targets: 
        [
          //AppObject.getAs(table_form.fields['client_id'].tree_object, SelectField)
        ]
      });      
    }
        
        
    /*
    Browser.window.setTimeout(function()
    {
      _('#add-test').velocity('callout.tada');
      //_('#add-test').velocity('transition.flipXIn');
    }, 800);
    */
  }


  override function onAttach()
  {
    super.onAttach(); 
    
    menu_ext._menu.find('input[type=checkbox]').on('change', function(e)
    {
      var _tr = Reflect.field(menu_ext.menu, "$trigger");
      var item = items_map[_tr.data('id')];        
      
      rowsMenuOnCancel(item, menu_ext);
      menu_ext._menu.trigger('contextmenu:hide');
    });

  }      
  
  
  function rowsMenuOnCancel(item:TableItem, menu:TableItemsMenuExtension, ?cb_name:String)
  {    
    var flags = getDirtyItemVal(item, 'flags');
    
    var pos = flags.indexOf('canceled');
    if (pos >= 0) {
      flags.splice(pos, 1);
    }
    else {
      flags.push('canceled');
    }
    
    //log(['pre', flags.join(', ')]);
    
    saveItem(item, { flags: flags });       
  }


  override function getListSingleItemOptions():Dynamic
  {
    var opt = getListOptions();
    
    opt.where = 
    [
      ['o.id', '=', '{!id!}']
    ];
    
    return opt;
  }


  override function getListOptions():Dynamic
  {    
    var fields = filter_form.fields;

    var d1:String = fields['start_date'].val;
    var d2:String = fields['end_date'].val;
    

    if (d1.length > 0 && d2.length > 0 && d1 > d2) 
    {
      var t = d1;
      d1 = d2;
      d2 = t;
      
      fields['start_date'].val = d1;
      fields['end_date'].val = d2;
    }
                
    
                
    if (fields['end_date'].val.length > 0)
    {
      var a:Array<String> = fields['end_date'].val.split(':');
      a[a.length-1] = '59';
      fields['end_date'].val = a.join(':');
    }
    
    
    //log(filter_form.values());    

    var where: Array<Array<Dynamic>> = [];
    

    if (fields['start_date'].val.length > 0) {
      where.push(['time', '>=', fields['start_date'].val]);
    }

    if (fields['end_date'].val.length > 0) {
      where.push(['time', '<=', fields['end_date'].val]);
    }
    
    if (fields['phone'].val.length > 0) {
      where.push(['c.phone', 'like', '%'+fields['phone'].val+'%']);
    }
    
    var opt = super.getListOptions();
    
    opt.table_alias = 'o';
    opt.select = untyped ['o.*', ['c.name', 'client_name'], ['c.phone', 'client_phone'] ];
    opt.left_outer_join = untyped [['clients', ['o.client_id', '=', 'c.id'], 'c']];
    opt.where = where;
    opt.order_by_desc = ['time', 'id'];
    
    return opt;
  }


  override public function addItems(part_items_raw:Array<Dynamic>, ?at_top:Bool=false, ?highlight:Bool=false):Array<TableItem>
  {
    var part_items = super.addItems(part_items_raw, at_top, highlight);
    

    for (item in part_items)
    {
/*      
      item._tr.on('contextmenu', function(e)
      {
        e.preventDefault();
        
        var tr = e.currentTarget;
        var id:Int = _(tr).data('id');
        
        var item = rows_menu_table_item = items_map[id];
        
        rows_menu_canceled.checked = (item.fields.flags.indexOf('canceled') >= 0);
        
        rows_menu.popup(e.clientX, e.clientY);
      });
*/
      setStatusColor(item, item.fields);
      initItemPopover(item);
    }
    
    
    return part_items;
  }
  
  
  
  function initItemPopover(item:TableItem)
  {
    var content_count = 0;
    
    /*
    .on('mouseenter', function(e)
    {
      //e.preventDefault();
      //e.stopImmediatePropagation();
            
    });*/

        
    item._tr.find('> td:first').popover(
    {
      content: function() 
      { 
        content_count++;    // popover calls content() twice: first on hasContent()         
        if (content_count & 1 > 0) return 'hasContent';                   
        
        return callMacro('itemPopover', {
          item: item.fields
        });
      }, 
      delay: 200,
      trigger: 'hover',
      html: true,
      container: 'body'
    });
    
  }
  
  
  function setStatusColor(item:TableItem, fields:Dynamic)
  {
    var canceled_pos = fields.flags.indexOf('canceled');
    var modified_pos = fields.flags.indexOf('modified');
     
    var rem_classes = ['modified', 'canceled'];
    var add_class:String = null;
    
    if (canceled_pos >= 0) {
      add_class = 'canceled';      
    }
    else if (modified_pos >= 0) {
      add_class = 'modified';      
    }
    
    if (add_class != null)
    {
      var p = rem_classes.indexOf(add_class);
      rem_classes.splice(p, 1);      
    }
    
    //log(['rem', rem_classes.join(', ')]);
    //log(['add', add_class]);
    
    item._tr.find('> td').each(function(i, td)
    {
      for (c in rem_classes)
      {
        _(td).removeClass(c);              
      }
      
      if (add_class != null) {
        _(td).addClass(add_class);              
      }
      
    });
    
  }
  
  
  override public function saveItem(item:TableItem, values:Dynamic, ?options:Dynamic)
  {    
    var keys = Reflect.fields(values);
    var flags_is_only = (keys.length == 1 && keys[0] == 'flags');

    if (!flags_is_only)
    {
      if (values.flags != null) 
      {
        if (values.flags.indexOf('modified') == -1) {
          values.flags.push('modified');
        }      
      }
      else if (item.fields['flags'].indexOf('modified') == -1) 
      {      
        values.flags = item.fields['flags'].slice(0);
        values.flags.push('modified');
      }
    }
    
    
    if (options == null) options = {};
        
    var on_success = options.on_success;
    var on_error = options.on_error;
    
    options.on_success = function(result)
    {
      setStatusColor(item, item.fields);   
      
      if (Reflect.isFunction(on_success)) {
        on_success(result);
      }        
    }
    
    options.on_error = function(result)
    {
      setStatusColor(item, TableView.getDirtyItemValues(item));        
      
      if (Reflect.isFunction(on_error)) {
        on_error(result);
      }              
    }     
    
    return super.saveItem(item, values, options);
  }
  
}


