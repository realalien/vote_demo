class CreateSurveySheets < ActiveRecord::Migration
  def self.up
    create_table :survey_sheets do |t|
	t.timestamps :created_when
	t.timestamps :last_modified_when
	t.integer :modification_count
	t.integer :user_id    # the user who submit the sheet
	t.integer :survey_id   # from which model of survey, the sheet is generated.
      t.timestamps
    end
  end

  def self.down
    drop_table :survey_sheets
  end
end
