class Section < ActiveRecord::Base
  belongs_to :survey
  
  validates_uniqueness_of :number
end
