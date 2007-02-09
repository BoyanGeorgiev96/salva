class ProjectController < SalvaController
  def initialize
    super
    @model = Project
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @children = { 'projectinstitution' => %w( project_id institution_id ),
                  'projectfinancingsource' => %w( project_id institution_id amount), 
                  'projectresearchline' => %w(researchline_id) }
  end
end
