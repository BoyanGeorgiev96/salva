class UserProceedingRefereedController < SalvaController
  def initialize
    super
    @model = UserProceeding
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:proceeding], :conditions => "proceedings.isrefereed = 't' AND proceedings.id = user_proceedings.proceeding_id "}

  end
end
