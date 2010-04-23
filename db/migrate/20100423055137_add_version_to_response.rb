class AddVersionToResponse < ActiveRecord::Migration
  def self.up
    add_column :responses, :version, :integer, :default => 1
  end

  def self.down
    drop_column :responses, :version
  end
  
end
