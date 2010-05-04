class AddVerionFu < ActiveRecord::Migration
  def self.up
      #drop_table :response_versions
      # create version table for responses
      create_table :response_versions do |t|
	       t.integer :response_id 
         t.integer :version
	       t.integer :user_id  # user_id is to record the multiple users if collab
	       t.integer :rating
         t.text :answer_text
         t.timestamp :updated_at
      end
  end

  def self.down
      drop_table :response_versions
  end
end
