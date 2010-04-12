class CreateTravelPlaces < ActiveRecord::Migration
  def self.up
    create_table :travel_places do |t|
      t.string :name
      t.string :description
      t.string :photo

      t.timestamps
    end
  end

  def self.down
    drop_table :travel_places
  end
end
