class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.string :server_path
      t.text :exif
      t.integer :team_id
      t.integer :photo_category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
