class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.text :hint
      t.boolean :is_commentable
      t.boolean :is_rateable
      t.boolean :is_voteable   # not for individual users, public statistic use.
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
