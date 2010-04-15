class CreateSheetQuestionRelations < ActiveRecord::Migration
  def self.up
    create_table :sheet_question_relations do |t|
	   t.integer :survey_sheet_id
	   t.integer :question_id
	   # t.integer :user_id   
     # * I think there is no need to record such data as 
     #    users should not modify the questions and we won't record.
	   t.timestamps :last_modified_when
     t.timestamps
    end
  end

  def self.down
    drop_table :sheet_question_relations
  end
end
