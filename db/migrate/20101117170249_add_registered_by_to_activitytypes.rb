class AddRegisteredByToActivitytypes < ActiveRecord::Migration[6.1]
  def self.up
    if column_exists? :activitytypes, :moduser_id
      rename_column :activitytypes, :moduser_id, :registered_by_id
    else
      add_column :activitytypes, :registered_by_id, :integer
    end

    add_column :activitytypes, :modified_by_id, :integer
  end

  def self.down
    rename_column :activitytypes, :registered_by_id, :moduser_id
    remove_column :activitytypes, :modified_by_id
  end
end
