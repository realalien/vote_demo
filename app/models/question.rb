class Question < ActiveRecord::Base
	acts_as_commentable
	has_many :survey_question_assignments, :dependent => :nullify
	has_many :surveys,	:through => :survey_question_assignments
	
	has_many :question_answer_by_users, :dependent => :nullify
	has_many :answers, :through => :question_answer_by_users
end
