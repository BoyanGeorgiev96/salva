class UserInproceedingUnrefereedController < SalvaController
  def initialize
    super
    @model = UserInproceeding
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = {:joins => "INNER JOIN proceedings ON proceedings.isrefereed = 'f' INNER JOIN inproceedings ON inproceedings.proceeding_id = proceedings.id AND inproceedings.id = user_inproceedings.inproceeding_id"}
  end
end
