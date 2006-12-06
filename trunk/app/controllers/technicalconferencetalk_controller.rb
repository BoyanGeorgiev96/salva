class TechnicalconferencetalkController < SalvaController
  def initialize
    super
    @model = Conferencetalk
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:conference], :conditions => "conferences.conferencetype_id = 1 AND conferences.istechnical = 't' AND  conferencetalks.conference_id = conferences.id "}
  end
end
