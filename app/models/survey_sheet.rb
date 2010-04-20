class SurveySheet < ActiveRecord::Base
  
    has_many :sheet_question_relations, :dependent => :nullify
    has_many :questions, :through => :sheet_question_relations
    # note: the intermediate table is used to record data like 'sequence in the survey, difficulty or extra info'
    
    # Notes, answers is replaced by Response, because Model answers doesn't include data like 'survey_id, question_id'
    #has_many :sheet_answer_relations, :dependent => :nullify
    #has_many :answers, :through => :sheet_answer_relations
    
    
    has_many :responses, :dependent => :nullify
    
    # Notes: though  responses have user_id info, I think we can make 
    #  query much easier to keep a   survey_sheet -has_many-> users, shall I? 
     
end
