class CreateSheetAnswerRelations < ActiveRecord::Migration
  def self.up
    create_table :sheet_answer_relations do |t|
    	 t.integer :survey_sheet_id
    	 t.integer :answer_id
       t.integer :question_id  # (otherwise we can't track the answer to the question)
       t.integer :user_id
       t.timestamps :last_modified_when
    end
  end

  def self.down
    drop_table :sheet_answer_relations
  end
end
