class CreatePhotoCategories < ActiveRecord::Migration
  def self.up
    create_table :photo_categories do |t|
      t.string :name
      t.integer :photo_id
      t.timestamps
    end
  end

  def self.down
    drop_table :photo_categories
  end
end
