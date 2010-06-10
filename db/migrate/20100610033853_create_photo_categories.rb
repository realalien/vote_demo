class CreatePhotoCategories < ActiveRecord::Migration
  def self.up
    create_table :photo_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :photo_categories
  end
end
