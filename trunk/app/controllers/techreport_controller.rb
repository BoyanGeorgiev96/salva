class TechreportController < SalvaController
  def initialize
    super
    @model = Genericwork
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions => "genericworktype_id = 9" }
  end
end
