class AddTeamInfoToUser < ActiveRecord::Migration
  def self.up
	add_column :users, :team_name, :string
  end

  def self.down
  end
end
