class Question < ActiveRecord::Base
  
  
  
  ajaxful_rateable :stars => 10 ,  :dimensions => [:description]
	acts_as_commentable
  
	has_many :survey_question_assignments, :dependent => :nullify
	has_many :surveys,	:through => :survey_question_assignments
	
  
  has_many :responses;
  belongs_to :section  
  # NOTE: 20100419, it looks like that the question is not  
 

	#has_many :question_answer_by_users, :dependent => :nullify
	#has_many :answers, :through => :question_answer_by_users
  
  #accepts_nested_attributes_for :answers, :allow_destroy => true
  #accepts_nested_attributes_for :question_answer_by_users
  
   # has_many :sheet_question_relations, :dependent => :nullify
   # has_many :survey_sheets, :through => :sheet_question_relations
  
  # http://railscasts.com/episodes/75-complex-forms-part-3
  
#  def new_answer_attributes=(answer_attributes)
#    answers_attributes.each do |attributes|
#      answers.build(attributes)
#    end
#  end

  
  
  
end
