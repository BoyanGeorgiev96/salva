class BookeditionRoleinbookController < SalvaController
  def initialize
    @model = BookeditionRoleinbook
    @create_msg = 'La edici�n  ha sido agregada'
    @update_msg = 'La edici�n ha sido actualizada'
    @purge_msg = 'La edici�n ha sido borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
