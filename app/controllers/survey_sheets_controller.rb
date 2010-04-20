
# Purpose: allow users/manager to give answer to a survey
# INFO: not restful at the moment
# SUG: study the code of SMERF to incorporate the restful
# INFO: I doubt bundling of models could be nice design, but it has to be for now!
class SurveySheetsController < ApplicationController

    before_filter :login_required
    
    # GET /survey_sheet/id
    #  
    # or name
    def show
      if params["id"]
        suppose_survey_def_id = params["id"]
        @survey = Survey.find(suppose_survey_def_id)
        @questions = @survey.questions  # TODO: sort by sequence
        #@answers ||= QuestionAnswerByUser.find(:all, :conditions => { :user_id => self.current_user } )  
        #TODO: if @answers are in version, try to load the latest answers
        
        # get responses, if any, render 'edit'; it not , render 'create'
        # TODO: revise the code to ellaminate the sql queries
        any_responses = Response.find(:first, :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }  ] )
        
        # INFO: it looks like render does not go through the corresponding method 
        if any_responses
          # load survey_sheet 
           @survey_sheet = SurveySheet.find(:first, 
                                          :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }  ] )
          
          render(:action => "edit")
        else
           @survey_sheet = SurveySheet.find(:first, 
                                          :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }  ] )
          render(:action => "create")
        end
      end
    end
  
    # POST /smerf_forms
    # why new? 
    # create a record of question_answer_by_user?
    # TODO: how to make user into such controller/action?
    def create
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
              # TODO: log here!
              
              if @survey_sheet
                  # load all the responses of the users, to the specified survey for editing
                  rs = Response.find(:all, :condition => [ "user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }   ] )
                  
                  @survey_sheet.responses << rs  # if we eagerly retrieve the data, maybe there is no need to do this op!

                  # TODO: go to edit page   edit/:target_survey_id
                  render(:action => "edit")
                  
              else # create a new survey_sheet
                @survey_sheet = SurveySheet.new
                
                
                @survey_sheet.questions << survey_def.questions # create a new survey_sheet
                # Q: what about the change of survey_def?
                
                # 20100419 Be sure to setup responses with question id
                # wrong: @survey_sheet.questions.size.times { @survey_sheet.answers.build } # we can not setup the response's attr this way.
                
                # To make it clear, the response model should include 
                # 'user_id','question_id','rate_value'(if rateable),'comment text(if commentable)'  (later include privilege setting)
                
                @survey_sheet.questions.each do |question|
                  # create a response object
                  r = Response.new()
                  r.survey_id = suppose_survey_def_id
                  r.question_id = question.id
                  r.user_id = self.current_user.id
                  @survey_sheet.responses << r 
                  # link response object, user_id, survey_id into a model for later ref. 
                end
                
              end
          end
          
           
          
        end
    end
  
    # PUT /smerf/1
    def update
      
    end

  
  
end