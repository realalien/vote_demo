class CreateSheetHistories < ActiveRecord::Migration
  def self.up
    create_table :sheet_histories do |t|
      t.integer :user_id
      t.integer :survey_sheet_id
      t.datetime :when_submit
    
      t.timestamps
    end
  end

  def self.down
    drop_table :sheet_histories
  end
end
