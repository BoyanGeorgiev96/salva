class UserConferencetalkController < SalvaController
  def initialize
    super
    @model = UserConferencetalk
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = {:joins => "INNER JOIN conferences ON conferences.istechnical = 'f' INNER JOIN conferencetalks ON conferencetalks.conference_id = conferences.id AND conferencetalks.id = user_conferencetalks.conferencetalk_id"}
  end
end
