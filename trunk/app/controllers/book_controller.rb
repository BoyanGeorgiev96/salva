class BookController < SalvaController
  def initialize
    super
    @model = Book
    @create_msg = 'La informaci�n se ha guardado'
    @update_msg = 'La informaci�n ha sido actualizada'
    @purge_msg = 'La informaci�n se ha borrado'
    @per_pages = 10
    @order_by = 'id'

    @children = { 'bookedition' => %w(year edition_id book_id) }
  end
end
