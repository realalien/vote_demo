
# Purpose: allow users/manager to give answer to a survey
# INFO: not restful at the moment
# SUG: study the code of SMERF to incorporate the restful
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
          suppose_survey_def_id = params["id"]
          # create a SurveySheet according to the Survey(definition) 
          survey_def = Survey.find(suppose_survey_def_id)
          
          
          if not survey_def:  
              render :text => "no such survey definition!"  # flash and redirect
          else
              # find if login user has that sheet, if any, go to edit page
              # Q: if find(:first) not sequently first, else how?
              
              # * SUG 20100419: like smerf, I think it could be easier to load 
              #   the form_defintion(question with ids) 
              #   and all the response to the form(responses with question_id, call model) 
              #   then, we can display one by one ( a response has a question id.)
              @survey_sheet = SurveySheet.find(:first, 
                                          :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }  ] )
            
              
              if @survey_sheet
                  # TODO: go to edit page   edit/:target_survey_id
              else # create a new survey_sheet
                @survey_sheet = SurveySheet.new
                
                
                @survey_sheet.questions << survey_def.questions # create a new survey_sheet
                # Q: what about the change of survey_def?
                
                # 20100419 Be sure to setup responses with question id
                # wrong: @survey_sheet.questions.size.times { @survey_sheet.answers.build }
                
                # To make it clear, the response model should include 
                # 'user_id','question_id','rate_value'(if rateable),'comment text(if commentable)'  (later include privilege setting)
                
                @survey_sheet.questions.each do |question|
                  # create a response object
                  Respon
                  # link response object, user_id, survey_id into a model for later ref. 
                end
                
              end
          end
          
           
          
        end
    end
  
    def edit
      
    end
  
  
end