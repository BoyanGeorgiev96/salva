class MigrateDocumentAndUserDocumentToDocumenttypes < ActiveRecord::Migration[6.1]
  def self.up
    Document.all.each do |record|
      name = [record.documenttype.name, record.title].join(' - ')
      unless name.nil?
        @document_type = Documenttype.create(:name => name, :start_date => record.startdate, :end_date => record.enddate, :year => record.title.to_i)
        UserDocument.where(:document_id => record.id).all.each do |user_record|
          puts "Updating: user_id => #{user_record.user_id}, :documenttype_id => #{@document_type.id}"
          user_record.update(:documenttype_id => @document_type.id)
        end
      end
    end
  end

  def self.down
  end
end
