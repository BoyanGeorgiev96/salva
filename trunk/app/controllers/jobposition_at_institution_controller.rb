class JobpositionAtInstitutionController < SalvaController
  def initialize
    super
    @model = Jobposition
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @list_include = :institution
    @list_conditions = "(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id "
  end
end
