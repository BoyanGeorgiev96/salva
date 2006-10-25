require 'list_helper'
require 'application_helper'
require 'salva_helper'
module SelectHelper   
  def table_select_puerco(object, model, tabindex, validation_type, html_options={})
    #options = set_options_tags(tabindex, validation_type)
    model_id = set_model_id(model)
    #    model_id = prefix + '_' + model_id if prefix !=nil
    select(object, model_id, sorted_find(model), {:prompt => '-- Seleccionar --'}, html_options)
  end
  
  def table_select(object, model, tabindex, validation_type=nil, prefix=nil)
    options = set_options_tags(tabindex, validation_type)
    model_id = set_model_id(model)
    model_id = prefix + '_' + model_id if prefix !=nil
    select(object, model_id, sorted_find(model), {:prompt => '-- Seleccionar --'}, options)
  end
  
  def select_to_update_select(obj, model, model_dest, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    options[:onchange] = remote_functag(model, model_dest, tabindex) 
    select(obj, set_model_id(model), sorted_find(model), { :prompt => '-- Seleccionar --' }, options)
  end
  
  def select_id_to_update_select(obj, model, model_parent, id, model_dest, tabindex, validation_type=nil, columns=['name']) 
    options = set_options_tags(tabindex, validation_type)
    conditions = [ set_model_id(model_parent) + ' = ?', id ]
    collection = model.find(:all, :conditions => conditions)
    list = list_collection(collection,  columns) 
    options[:onchange] = remote_functag(model, model_dest, tabindex) if model_dest != nil
    select(obj, set_model_id(model), list, {:prompt => '-- Seleccionar --'}, options)
  end
  
  def select_by_attribute(object, model, tabindex, validation_type=nil, model_id=nil, attribute='name')
    options = set_options_tags(tabindex, validation_type)
    attribute_id = model_id != nil ? model_id : set_model_id(model)
    select(object, attribute_id, sorted_find(model, attribute), {:prompt => '-- Seleccionar --'}, options)
  end
  
  def select_as_tree(object, model, columns, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    collection = model.find(:all)
    list = list_collection(collection, columns)
    fieldname = set_model_id(model) 
    fieldname = 'parent_id' if columns.include? 'parent_id'
    select(object, fieldname, list, {:prompt => '-- Seleccionar --'}, options)
  end
  
  def select_adscription(object, model, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    institution_id = get_myinstitution_id 
    if institution_id != nil
      list = list_from_collection(model.find(:all, :order => 'name DESC', :conditions => [ 'institution_id = ?', institution_id]))
    else
      list = list_from_collection(model.find(:all, :order => 'name DESC'))
    end
    select(object, set_model_id(model), list, {:prompt => '-- Seleccionar --'}, options)
  end

  def select_without_universities(object, model, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    list = list_from_collection(model.find(:all, :order => 'name DESC', :conditions => [ 'institutiontitle_id != ?', 1]))
    select(object, set_model_id(model), list, {:prompt => '-- Seleccionar --'}, options)
  end

  def select_institution(object, model, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    list = list_from_collection(model.find(:all, :order => 'name DESC', :conditions => [ 'institution_id = ?', 1]))
    select(object, set_model_id(model), list, {:prompt => '-- Seleccionar --'}, options)
  end

  private
  def set_options_tags(tabindex,validation_type=nil)
    options = Hash.new
    options = set_zebda_tags(validation_type) if validation_type != nil
    options[:tabindex] = tabindex 
    options
  end

  def set_zebda_tags(type)
    case type
    when 1  
      { 'z:required' => 'true', 'z:required_message' => 'Seleccione una opci�n' }
    when 2
      { 'z:required' => 'true', 'z:required_message' => 'Registre la informaci�n de este campo' }
    else
    end
  end  

  def remote_functag(origmodel, destmodel, tabindex, prefix=nil)
    partial = "select_#{origmodel.name.downcase}_#{destmodel.name.downcase}" 
    params = "'partial=#{partial}&tabindex=#{tabindex}&id='+value"
    partial_note =  partial + "_note"
    success_msg = "Effect.BlindUp('#{partial_note}', {duration: 0.5});; "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{partial_note}');"
    remote_function(:update => partial, :with => params, :url => {:action => :update_select},
                    :loading => loading_msg, :success => success_msg)
  end

  def select_institutioncareer_by_degree(obj, model, columns, id, tabindex, validation_type=nil)
    options = set_options_tags(tabindex, validation_type)
    collection = model.find_by_sql "SELECT ic.id, ic.career_id, ic.institution_id FROM institutioncareers ic, careers c WHERE c.degree_id = #{id} AND c.id = ic.career_id"
    list = list_collection(collection,  columns) 
    select(obj, set_model_id(model), list, {:prompt => '-- Seleccionar --'})
  end
end  
