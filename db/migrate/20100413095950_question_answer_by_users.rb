class QuestionAnswerByUsers < ActiveRecord::Migration
  def self.up
	create_table :question_answer_by_users do |t|
    	t.integer :question_id, :null => false
	    t.integer :answer_id, :null => false
	    t.integer :user_id
    	t.timestamps
	end
  end

  def self.down
	drop_table :question_answer_by_users
  end
end
