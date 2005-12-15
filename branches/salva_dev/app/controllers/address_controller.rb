class AddressController < SalvaController
  def initialize
    super
    @model = Address
    @create_msg = 'La direcci�n se ha guardado'
    @update_msg = 'la direcci�n se ha actualizado'
    @purge_msg = 'La direcci�n ha sido borrada'
    @per_pages = 10
    @order_by = 'postaddress DESC'
  end
end
