class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'La direcci�n ha sido agregado'
    @update_msg = 'La direcci�n ha sido actualizado'
    @purge_msg = 'La direcci�n se ha borrado'
    @per_pages = 10
    @order_by = 'addresstype_id, addr'
  end
end
