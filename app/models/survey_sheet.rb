class SurveySheet < ActiveRecord::Base
  
    has_many :sheet_question_relations, :dependent => :nullify
    has_many :questions, :through => :sheet_question_relations
    # note: I don't think the has_many,through is nice here
    
    
end
