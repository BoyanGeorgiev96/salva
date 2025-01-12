class RemoveRecordsWithoutAssociatedRecords < ActiveRecord::Migration[6.1]
  def up
    #execute "ALTER TABLE techproducts DROP CONSTRAINT techproducts_institution_id_fkey"
    #execute "ALTER TABLE techproducts DROP CONSTRAINT techproducts_techproducttype_id_fkey"
    [Journal, Publisher, Institution,  Skilltype, Schoolarship, Career,
     Techproducttype, Stimulustype, Institutiontitle, Institutiontype].each do |class_name|
      associations = (class_name.reflect_on_all_associations(:has_many) + class_name.reflect_on_all_associations(:has_one)).collect { |association|  association.name }
      puts "Deleting records without associations in #{class_name}..."
      class_name.all.each do |record|
        associated_records = 0
        associations.each do |name|
          associated_records += record.send(name).count
        end
        puts "Deleting #{class_name}: " + [record.id, record.name].join(' -> ')
        record.destroy if associated_records == 0
      end
    end
  end

  def down
  end
end
