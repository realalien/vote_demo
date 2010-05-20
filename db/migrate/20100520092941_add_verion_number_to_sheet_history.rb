class AddVerionNumberToSheetHistory < ActiveRecord::Migration
  def self.up
      add_column :sheet_histories, :version_num, :integer
  end

  def self.down
  end
end
