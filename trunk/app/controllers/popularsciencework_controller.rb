class PopularscienceworkController < SalvaController
  def initialize
    super
    @model = Genericwork
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = {:joins => "INNER JOIN genericworkgroups ON genericworkgroups.name = 'Productos de divulgaci�n'  INNER JOIN genericworktypes ON genericworktypes.genericworkgroup_id = genericworkgroups.id AND genericworks.genericworktype_id = genericworktypes.id"}
  end
end
