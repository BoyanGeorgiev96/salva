class TechnicalconferenceController < SalvaController
  def initialize
    super
    @model = Conference
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:conferencetype], :conditions => "conferencetypes.name = 'Congreso' AND conferencetypes.id = conferences.conferencetype_id AND conferences.istechnical = 't'"}
  end
end
