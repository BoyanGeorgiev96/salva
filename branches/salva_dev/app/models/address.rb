class Address < ActiveRecord::Base
  validates_presence_of :addresstype_id, :message => "Proporcione el tipo de direcci�n"
  validates_presence_of :country_id, :message => "Proporcione el pa�s"
  validates_presence_of :postaddress, :message => "Proporcione la direcci�n"
  validates_presence_of :city, :message => 'Proporcione la informaci�n de la ciudad'
  validates_presence_of :mail, :message => 'Indique si usara esta direcci�n como domicilio postal'
end
