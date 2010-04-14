
# Purpose: allow users/manager to give answer to a survey
# INFO: not resourceful/restful
class SurveySheetsController < ApplicationController

    before_filter :login_required
    
    # 
    def show
      if params["id"]
        @survey = Survey.find(params["id"])
        @questions = @survey.questions  # TODO: sort by sequence
        #@answers ||= QuestionAnswerByUser.find(:all, :conditions => { :user_id => self.current_user } )  
        #TODO: if @answers are in version, try to load the latest answers
      end
    end
  
    # why new? 
    # create a record of question_answer_by_user?
    # TODO: how to make user into such controller/action?
    def new
        if params["id"]
          # create a SurveySheet according to the Survey(definition) 
          survey_def = Survey.find(params["id"])

          if survey_def.questions.size > 0
              @survey_sheet = SurveySheet.new
              @survey_sheet.questions << survey_def.questions # create a new survey_sheet
              # Q: what about the change of survey_def?
               
          end
          
          
          
          @questions = survey.questions  # TODO: sort by sequence
          @question.each do | qu |
               qu.answers.build  # create answer in the memory, Q: what's the use of 'build',  what about the associated model
               
          end
        end
    end
  
    # allow user to modify the answers, there will be
    def edit
      
    end
  
  
end