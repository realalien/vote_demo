class SurveySheet < ActiveRecord::Base
  
    has_many :sheet_question_relations, :dependent => :nullify
    has_many :questions, :through => :sheet_question_relations
    # note: I don't think the has_many,through is nice here
    
    has_many :sheet_answer_relations, :dependent => :nullify
    has_many :answers, :through => :sheet_answer_relations
end
