class MoveInstitutionCareerIdInToCareerIdInTutorialCommittees < ActiveRecord::Migration[6.1]
  def self.up
    TutorialCommittee.all.each do |record|
      career_id = record.institutioncareer.career_id
      unless career_id.nil?
        record.career_id = career_id
        record.save
        institution_id = record.institutioncareer.institution_id
        unless institution_id.nil?
          career = Career.find(record.career_id)
          career.update(:institution_id => institution_id, :degree_id => record.degree_id)
        end
      end
      record.save
    end
  end

  def self.down
    TutorialCommittee.all.each do |record|
      unless record.career_id.nil?
        record.career.update_attribute(:institution_id, nil)
        record.update_attribute(:career_id, nil)
      end
    end
  end
end
