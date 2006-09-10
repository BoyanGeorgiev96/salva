class SchoolingController < SalvaController
  def initialize
    @model = Schooling
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'endyear, startyear DESC'
    @sequence = [ [ Schooling, Professionaltitle] ]
  end
end
