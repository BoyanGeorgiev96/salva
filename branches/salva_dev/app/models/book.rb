class Book < ActiveRecord::Base
  validates_presence_of :title, :message => "Proporcione el t�tulo"
  validates_presence_of :author, :message => "Proporcione el autor"
end
