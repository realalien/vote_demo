class CreateSheetQuestionRelations < ActiveRecord::Migration
  def self.up
    create_table :sheet_question_relations do |t|
	   t.integer :survey_sheet_id
	   t.integer :question_id
     t.timestamps
    end
  end

  def self.down
    drop_table :sheet_question_relations
  end
end
