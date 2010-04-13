class Survey < ActiveRecord::Base
	has_many :survey_question_assignments, :dependent => :nullify
	has_many :questions, :through => :survey_question_assignments
end
