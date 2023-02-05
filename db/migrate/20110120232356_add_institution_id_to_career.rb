class AddInstitutionIdToCareer < ActiveRecord::Migration[6.1]
  def self.up
    add_column :careers, :institution_id, :integer
  end

  def self.down
    remove_column :careers, :institution_id
  end
end
