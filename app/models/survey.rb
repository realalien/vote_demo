class Survey < ActiveRecord::Base

  
  validates_uniqueness_of :title, :message => "the title has already been used!"
  validates_presence_of(:title, :message => "must give a title to make later modification easier!")
  
	has_many :survey_question_assignments, :dependent => :nullify
	has_many :questions, :through => :survey_question_assignments
  
  has_many :sheets
  has_many :sections
end
