class Answer < ActiveRecord::Base

    has_many :question_answer_by_users, :dependent => :nullify
	  has_many :questions, :through => :question_answer_by_users

    has_many :sheet_answer_relations, :dependent => :nullify
    has_many :survey_sheets, :through => :sheet_answer_relations

end
