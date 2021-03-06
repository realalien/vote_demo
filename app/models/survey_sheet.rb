class SurveySheet < ActiveRecord::Base
  
    has_many :sheet_question_relations   # do not delete that, maybe used in history recording. If use known, warning should be given.
    has_many :questions, :through => :sheet_question_relations, :dependent => :destroy
    # note: the intermediate table is used to record data like 'sequence in the survey, difficulty or extra info'
    # note: 20100421, I think such info should be kept by the survey_def, instead of by individual sheet.
    #                 Sorry, to keep the load more easily, questioi
    #      TODO: handling the sync of definition.quesitons and sheet.questions.
    
    #has_many :sheet_answer_relations, :dependent => :nullify
    #has_many :answers, :through => :sheet_answer_relations
    # Notes, answers is replaced by Response, because Model answers doesn't include data like 'survey_id, question_id'
    
    has_many :responses, :dependent => :nullify
    
    # Notes: though  responses have user_id info, I think we can make 
    #  query much easier to keep a   survey_sheet -has_many-> users, shall I? 
   
    validates_presence_of(:user_id, :message => "must login to take a survey sheet! But no user_id found!")
    validates_presence_of(:survey_id, :message => "must reference to a survey definition! Survey ID not assigned! ")

    belongs_to :user
    belongs_to :survey
    
    has_many :sheet_histories
    
    def remove_all_responses
      self.responses = []
    end
    
    def reload_history_by_version_num(ver_num)
      
      logger.debug "------------------------------------"
      logger.debug "Ver_num.nil? is #{ver_num.nil?}"
      
      if ver_num
          self.remove_all_responses    
      else
          self.responses          
      end
    end
    
end
