class Response < ActiveRecord::Base

  # TODO: test if we can create call association version.
  version_fu do 
    belongs_to :survey_sheet, :class_name => "::SurveySheet"
  end
  
  validates_presence_of :survey_sheet_id, :question_id, :user_id
  belongs_to :survey_sheet
  
  # callback call for versioning
  def create_new_version?
      rating_changed? or answer_text_changed?
  end
end
