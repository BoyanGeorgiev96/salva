class GroupController < SalvaController

  def initialize
    super
    @model = Group
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id, name, group_id'
  end

end
