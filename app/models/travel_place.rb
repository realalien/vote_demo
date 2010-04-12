class TravelPlace < ActiveRecord::Base
	has_and_belongs_to_many :users
	acts_as_voteable
end
