class FixOldDbJournalsColumns < ActiveRecord::Migration[6.1]
  def self.up
    unless column_exists? :journals, :impact_index
      add_column :journals, :impact_index, :float
    end
  end

  def self.down
  end
end
