class SheetHistory < ActiveRecord::Base
    belongs_to :survey_sheet
    validates_presence_of :user_id, :when_submit
    
    belongs_to :user
end
