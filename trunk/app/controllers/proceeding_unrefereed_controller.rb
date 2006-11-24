class ProceedingUnrefereedController < SalvaController
  def initialize
    super
    @model = Proceeding
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions => " isrefereed = 'f' " }
  end
end
