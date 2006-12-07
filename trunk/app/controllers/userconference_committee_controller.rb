class UserconferenceCommitteeController < SalvaController
  def initialize
    super
    @model = Userconference
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleinconference], :conditions => "roleinconferences.name != 'Asistente'  AND userconferences.roleinconference_id = roleinconferences.id"}
  end
end
