class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.integer :survey_id
      t.integer :user_id
      t.integer :question_id
      t.integer :rating
      t.text :answer_text

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
