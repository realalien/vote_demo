class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.integer :number
      t.string :description
      t.integer :survey_id
      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
