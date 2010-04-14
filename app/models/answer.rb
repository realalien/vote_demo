class Answer < ActiveRecord::Base

    has_many :question_answer_by_users, :dependent => :nullify
	  has_many :questions, :through => :question_answer_by_users

end
