class CreateDocumentTypes < ActiveRecord::Migration[6.1]
  def self.up
    create_table :document_types do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :document_types
  end
end
