package view.address;


class AddressesView extends TableView
{ 
  public static var template_name : String = 'address/addresses.html';
  
  
  public function new()
  {
    model_name = 'Addresses';
    
    title = 'Adreses';
    item_name = 'adrese';
    item_name_multiple = 'adreses';
    item_is_female = true;
            
    super();
    
  }
      

  override function onOutput()
  {
    super.onOutput();

    var top_form = query({ classs: HtmlForm, fields: { tag_id: 'default-form' } }, { except: { classs: TableView }}, 1)[0];
    var table_form = query({ classs: HtmlForm, fields: { tag_id: 'table-form' } }, { except: { classs: TableView }}, 1)[0];
    
    data_bindings = 
    [
      {
        source: { method: 'Streets.getList', args: variable([Main.inst.models['Streets'].getListOptions()]) },
        targets: 
        [
          AppObject.getAs(top_form.fields['street_id'].tree_object, SelectField),
          AppObject.getAs(table_form.fields['street_id'].tree_object, SelectField)
        ],
        result_var: 'streets',
        result_var_map: true        
      }
    ];
    
  }  
        
}



class AddAddressView extends FormView
{   
  
  public function new()
  {    
    fields = Main.inst.models['Addresses'].populateFormFieldDefs(
    {
      street_id: { label: 'Iela', type: 'select' },      
      house_no: { label: 'Mājas numurs' },
      flat_no: { label: 'Dzīvokļa / kabineta numurs' },
      floor: { label: 'Stāvs' },
      doorcode: { label: 'Durvju kods' },
      notes: { label: 'Piezīmes vedējam', type: 'textarea' },
      notes_priv: { label: 'Iekšējās piezīmes', type: 'textarea' },
      company: { label: 'Firma' },
      
      is_yard: { label: 'Ir sētā?' },
      is_private: { label: 'Privātmāja?' },
      needs_call: { label: 'Zvanīt?' },
    });

    super();
   
  }

  
}

