
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
        
        # SUG: it is not suggested to treate id as definition 
        
        suppose_survey_def_id = params["id"]
        @survey_def = Survey.find(suppose_survey_def_id)
        #@questions = @survey.questions  # TODO: sort by sequence or some columns
        #@answers ||= QuestionAnswerByUser.find(:all, :conditions => { :user_id => self.current_user } )  
        #TODO: if @answers are in version, try to load the latest answers
        
        # get responses, if any, render 'edit'; it not , render 'create'
        # TODO: revise the code to ellaminate the sql queries
        any_responses = Response.find(:first, :conditions => ["user_id = :user_id and survey_sheet_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }  ] )
        
        # INFO: it looks like render does not go through the corresponding method 
        if any_responses
          # load survey_sheet 
           @survey_sheet = SurveySheet.find(:first, 
                                          :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => suppose_survey_def_id }  ] )
           logger.info("------------------------  #{@survey_sheet.responses.size}!")
           logger.info("------------------------survey definition question size:  #{@survey_def.questions.size} ---")
           # if newly create a question for the sheet, no corresponding responses, create one to let user fill in
           
           existing_questions_ids_in_responses = []
           @survey_sheet.responses.each { | r | existing_questions_ids_in_responses << r.id }
           logger.info("------------------------  #{existing_questions_ids_in_responses}!")
           
           existing_questions_ids_in_questions = []
           @survey_sheet.questions.each { | r | existing_questions_ids_in_questions << r.id }
           logger.info("------------------------  #{existing_questions_ids_in_questions}!")
           
           if @survey_sheet.questions.size < @survey_def.questions.size 
             for q in @survey_def.questions
                if not existing_questions_ids_in_questions.include? q.id
                # import new question.
                @survey_sheet.questions << q
                end
             end
           end
           
           if @survey_sheet.responses.size < @survey_def.questions.size 
             for q in @survey_def.questions
                # create new response
                if not existing_questions_ids_in_responses.include? q.id
                r = Response.new()
                r.survey_sheet_id = @survey_sheet.id
                r.question_id = q.id
                r.user_id = self.current_user.id
                @survey_sheet.responses << r 
                end
             end
           end
           
           
           render(:action => "edit")
        else  # no responses
           # make sure there also has No survey_sheet
             
           # create a SurveySheet according to the Survey(definition)
           suppose_survey_def_id = params["id"]
           survey_def = Survey.find(suppose_survey_def_id)
           
           if not survey_def:  
               render :text => "There is no such survey!"  # flash and redirect
           else
               # construct a new instance of survey_sheet to get template render correctly!
               @survey_sheet = SurveySheet.new
               @survey_sheet.survey_id = @survey_def.id
               @survey_sheet.user_id = self.current_user.id
               @survey_sheet.questions << survey_def.questions  # Q: what about the change of survey_def?
               @survey_sheet.save!  # in order to let responses recognize
               @survey_sheet.questions.each do |question|
                      # create a response object
                      r = Response.new()
                      r.survey_sheet_id = @survey_sheet.id
                      r.question_id = question.id
                      r.user_id = self.current_user.id
                      @survey_sheet.responses << r 
               end
               @survey_sheet.save!
               if @survey_sheet.errors.empty?
                  render(:action => "create")
               else
                  # print the error
                  render(:text => @survey_sheet.errors.to_s)
               end # if @survey_sheet.errors.empty?
           end  # not survey_def:  
        end # if any_responses
      end # if params["id"]
    end
  
    # POST /survey_sheets/id
    # why new? 
    # create a record of question_answer_by_user?
    # TODO: how to make user into such controller/action?
    def create
        # parse the parameters hash to create a object
        logger.info "in action create ............."
        if (params.has_key?(/response\d+/))
            #Q: if client fake the responses in the params, hwo to avoid those operations?
            # load the survey_sheet and its responses
            
            
            render :text => "in create methods."
        else
            render :text => "no response found in create!"
        end
        
        
    end
    
    # PUT /survey_sheets/1
    def update
        if (has_survey_responses(params))
            #render :text => "in update, params has responses, so we can parse and update!"
            # * parse and update the survey_sheet and responses, see if we can DRY by doing sth 
            #   in helper or rails multiple model updating
            sheet_id = params["survey_sheet_id"]
            
            
            @survey_sheet = SurveySheet.find(:first, :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                                                          { :user_id => self.current_user.id, 
                                                            :survey_id => sheet_id }  ] )
            
            @survey_sheet.responses.each do | response | 
              response.update_attribute(:updated_at ,Time.now)
              response.update_attribute(:answer_text, params["response#{response.question_id}"] )
              response.save!
            end
            @survey_sheet.save!
            render :action => "edit"
        else
            render :text => "no response found!"
        end
    end

    #/survey_sheets/
    def index
      @previous_sheets = SurveySheet.find(:all, :conditions => ["user_id = :user_id ", 
                                                          { :user_id => self.current_user.id }  ] )
      existing_ids = []
      @previous_sheets.each { |s| existing_ids << s.survey_id }
      @all_def = Survey.find(:all)
      @available_surveys = [] 
      
      @all_def.each do | s |
        @available_surveys << s  unless existing_ids.include?(s.id)
      end
       
    end
  
  
    def edit
     
    end


    private
    def has_survey_responses(params_hash)
       # assertion or sanity check  hash
       if params_hash.is_a?(Hash)
          params_hash.each_key do |key|
            if key =~ /response\d+/
              return true
            end
          end
          return false
       else
           return false
       end
    end
    
end


