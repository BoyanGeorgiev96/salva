class IdcitizenController < SalvaController
  def initialize
    super
    @model = Idcitizen
    @create_msg = 'La identificaci�n ha sido agregada'
    @update_msg = 'La identificaci�n ha sido actualizada'
    @purge_msg = 'La identificaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'identification_id, citizen_country_id'
  end
end
