class SheetAnswerRelation < ActiveRecord::Base
  
  belongs_to :survey_sheet
  belongs_to :answer
end
