class PeopleIdentificationController < SalvaController
  def initialize
    super
    @model = PeopleIdentification
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def index
    @citizen = Citizen.find(:first, :conditions => [ 'user_id = ?', session[:user]])
    if @citizen
      list
    else
      flash[:notice] = 'Por favor registre su nacionalidad antes de ingresar alguna de sus identificaciones (RFC, CURP, etc)...'
      redirect_to :controller => 'citizen', :action => 'list'
    end
  end
end
