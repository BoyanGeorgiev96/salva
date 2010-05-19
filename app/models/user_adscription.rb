class UserAdscription < ActiveRecord::Base
  validates_presence_of :adscription_id, :startyear

  validates_numericality_of :id, :jobposition_id, :user_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :adscription_id, :greater_than => 0, :only_integer => true
  validates_inclusion_of :startmonth, :endmonth,  :in => 1..12, :allow_nil => true

  belongs_to :jobposition
  belongs_to :adscription
  
  validates_associated :jobposition
  validates_associated :adscription
  
  after_create :update_user_id
  
  def update_user_id
    update_attributes(:user_id => jobposition.user_id) if self.user_id.nil?
  end
end