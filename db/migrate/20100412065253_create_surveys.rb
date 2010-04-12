class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :target_audience

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
