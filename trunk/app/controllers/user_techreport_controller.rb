class UserTechreportController < SalvaController
  def initialize
    super
    @model = UserGenericwork
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = {:joins => "INNER JOIN genericworks ON genericworks.genericworktype_id = 9 AND genericworks.id = user_genericworks.genericwork_id"}
  end
end
