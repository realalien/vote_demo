class Photo < ActiveRecord::Base
  validates_uniqueness_of :server_path
    
  has_one :photocategory
end
