class ResearchlineController < SalvaController
  auto_complete_for :researchline, :name
  def initialize
    super
    @model = Researchline
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
