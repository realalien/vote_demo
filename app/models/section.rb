class Section < ActiveRecord::Base
  belongs_to :survey
  has_many :questions  
  #validates_uniqueness_of :number
end
