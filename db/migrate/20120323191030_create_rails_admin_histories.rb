class CreateRailsAdminHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :rails_admin_histories do |t|
      t.text :message
      t.string :username
      t.integer :item
      t.string :table
      t.integer :month , :limit => 2
      t.integer :year, :limit => 5
      t.timestamps
    end
    add_index(:rails_admin_histories, [:item, :table, :month, :year], :name => 'index_rails_admin_histories' )
  end
end
