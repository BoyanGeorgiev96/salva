class JobpositionLogController < SalvaController
  def initialize
    super
    @model = JobpositionLog
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def list
    @jobposition_log = JobpositionLog.find_first([ 'user_id = ?', session[:user]])
    if @jobposition_log == nil
      new
    else
      redirect_to  :action => 'show', :id => @jobposition_log.id
    end  
  end
end
