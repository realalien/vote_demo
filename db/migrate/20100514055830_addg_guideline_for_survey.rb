class AddgGuidelineForSurvey < ActiveRecord::Migration
  def self.up
	add_column("surveys", "guideline", :text)
  end

  def self.down
	if table_exists?("surveys")
		drop_table "surveys"
	end
  end
end
