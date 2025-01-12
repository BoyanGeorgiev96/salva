class AddRegisteredByIdToReviews < ActiveRecord::Migration[6.1]
  def self.up
    if column_exists?  :reviews, :moduser_id
      rename_column :reviews, :moduser_id, :registered_by_id
    else
      add_column :reviews, :registered_by_id, :integer
    end

    add_column :reviews, :modified_by_id, :integer
  end

  def self.down
    rename_column :reviews, :registered_by_id, :moduser_id
    remove_column :reviews, :modified_by_id
  end
end
