class Question < ActiveRecord::Base
	acts_as_commentable
	has_many :survey_question_assignments, :dependent => :nullify
	has_many :surveys,	:through => :survey_question_assignments
end
