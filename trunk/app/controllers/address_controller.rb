class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'La direcci�n ha sido agregada'
    @update_msg = 'La direcci�n ha sido actualizada'
    @purge_msg = 'La direcci�n se ha borrada'
    @per_pages = 10
    @order_by = 'addresstype_id, addr'
  end
end
