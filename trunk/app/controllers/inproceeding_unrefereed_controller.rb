class InproceedingUnrefereedController < SalvaController
  def initialize
    super
    @model = Inproceeding
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:proceeding], :conditions => "inproceedings.proceeding_id = proceedings.id AND proceedings.isrefereed = 'f' "}
  end
end
