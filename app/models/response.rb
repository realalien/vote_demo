class Response < ActiveRecord::Base
  
  validates_presence_of :survey_sheet_id, :question_id, :user_id
  belongs_to :survey_sheet
end
