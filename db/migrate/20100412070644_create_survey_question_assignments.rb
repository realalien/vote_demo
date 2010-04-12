class CreateSurveyQuestionAssignments < ActiveRecord::Migration
  def self.up
    create_table :survey_question_assignments do |t|
      t.integer :survey_id, :null => false
      t.integer :question_id, :null => false
      t.integer :sequence
      t.timestamps
    end
  end

  def self.down
    drop_table :survey_question_assignments
  end
end
