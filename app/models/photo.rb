class Photo < ActiveRecord::Base
  validates_uniqueness_of :server_path
end
