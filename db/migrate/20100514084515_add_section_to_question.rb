class AddSectionToQuestion < ActiveRecord::Migration
  def self.up
	add_column(:questions, :section_id, :integer)
  end

  def self.down
  end
end
