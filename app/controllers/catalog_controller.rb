class CatalogController < InheritedResources::Base

  respond_to :json, :only => [:autocompleted_search, :create]
  respond_to :js, :only => [:new]

  def self.autocompleted_search_with(attribute, attribute_key, method_name=nil)
    method = method_name.nil? ? attribute.to_sym : method_name.to_sym
    define_method :autocompleted_search do
      set_collection_ivar self.resource_class.select("DISTINCT(#{attribute})").ransack.result(attribute_key.to_sym => params[:term]).all
      render :json => collection.collect { |record| {:id => record.id, :value => record.send(method).strip, :label => record.send(method).strip } }
    end
  end

  def create
    respond_to do |format|
      format.js { render :json => find_or_create_resource.to_json(:only => [:id, :name]) }
    end
  end

  private
  def find_or_create_resource
    h = params[resource_request_name] || params[resource_instance_name] || {}
    h.merge!(:is_verified => true) if resource_class.column_names.include? 'is_verified'
    object = resource_class.where(h).first
    if object.nil?
      h[:is_verified] = false if resource_class.column_names.include? 'is_verified'
      object = resource_class.new(h)
      object.registered_by_id = current_user.id
      object.save
    end
    object
  end
end
