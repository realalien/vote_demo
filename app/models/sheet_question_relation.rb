# Note: I found this model is dulplication of survey_question_assignment
# TODO: if possible, try to reuse  

class SheetQuestionRelation < ActiveRecord::Base
  belongs_to :question
  belongs_to :survey_sheet
 end
