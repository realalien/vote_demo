
# Purpose: allow users/manager to give answer to a survey
# INFO: not restful at the moment
# SUG: study the code of SMERF to incorporate the restful
# INFO: I doubt bundling of models could be nice design, but it has to be for now!
class SurveySheetsController < ApplicationController
  
  layout "site"
  
  before_filter :login_required
  
  # GET /survey_sheet/id
  #  
  # or name
  
  # Notes: I think to make everything right from the beginning, even the sheet history should be made resourceful TODO
  def show
    if params["id"]
      @survey_sheet = SurveySheet.find_by_id(params[:id])
      render :action => "edit"
    else
      render :text => "invalid request for retrieving survey sheet!"
    end
  end
  
  # POST /survey_sheets/id
  # TODO: how to make user into such controller/action?
  # is it a restful? 'new' instead of 'create'?
  def new
    # parse the parameters hash to create a object
    if (params.has_key?(:survey_id))
      #Q: if client fake the responses in the params, hwo to avoid those operations?
      # load the survey_sheet and its responses
      
      # test if user has done this survey, not always create a new copy.
      @user_did_sheet = SurveySheet.find(:all, :conditions => ["user_id = :user_id and survey_id = :survey_id", 
      { :user_id => self.current_user.id, 
        :survey_id => params[:survey_id] }  ]) 
      
      if @user_did_sheet and @user_did_sheet.size > 0
        # load sheet and render 
        @survey_sheet = @user_did_sheet 
        logger.debug "user has done the sheet before. #{@survey_sheet.size}............."
      else
        # create a new entries in the database;
        logger.debug "it's going to create sheet for user #{current_user.id}. ............."
        @survey_sheet = SurveySheet.new
        survey_template = params[:survey_id]
        survey_def = Survey.find_by_id(survey_template)
        @survey_sheet.survey_id = survey_template
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
        
        render :action => "edit"
        #render :text => "in create methods."
      end
    else
      render :text => "in valid request in answering a new survey!"
    end
  end
  
  # PUT /survey_sheets/1
  def update
    # TODO: try to retrieve the survey_sheet then update, avoid hacking by faking a id of non-self survey_sheet
    
    if (has_survey_responses(params))
      #render :text => "in update, params has responses, so we can parse and update!"
      # * parse and update the survey_sheet and responses, see if we can DRY by doing sth 
      #   in helper or rails multiple model updating
      sheet_id = params["id"]
      survey_id = params["survey_id"]
      
      @survey_sheet = SurveySheet.find(:first, :include =>:responses ,:conditions => ["user_id = :user_id and survey_id = :survey_id", 
      { :user_id => self.current_user.id, :survey_id => survey_id }  ] )
      
      logger.debug "@survey_sheet has responses size:  #{@survey_sheet.responses.size}"
      
      # TODO: make it a transaction to avoid dirty records
      ts = Time.now
      
      @a_version = SheetHistory.new
      @a_version.user_id = current_user.id
      @a_version.when_submit =  ts
      @survey_sheet.sheet_histories << @a_version
      @survey_sheet.responses.each do | response | 
        response.update_attribute(:updated_at ,ts )
        response.update_attribute(:answer_text, params["response#{response.question_id}"] )
        response.save!
      end
      @survey_sheet.save!
      @survey_sheet = SurveySheet.find_by_id(@survey_sheet.id)
      render :action => "edit"
    else
      render :text => "no response found!"
    end
  end
  
  # TODO: study the resourceful design and make the index action right
  # DOING: allow user to display a previous version.
  
  def index
     @survey_sheet = find_user_employee_form
     if @survey_sheet
        if params[:version_id]
            # load responses' previous version to get make page object displaying old versions.
            # the query criterior is:
            timestamp_end_version = SheetHistory.find_by_id(params[:version_id]).when_submit
            # ------ the right way is ------
            # to get all the responses which with 
            response_ids = []
            old_responses = {}
            
            # ESP.TODO: following code makes maintenance very hard! Find another way!
            @survey_sheet.responses.each do | resp |
              response_ids << resp.id
              old = ResponseVersion.find(:first, :condition => ["user_id = ? and updated_at <= ? ", current_user.id, timestamp_end_version ], :order => "when_submit DESC" )
              resp.rating = old.rating ; resp.answer_text = old.answer_text ;
            end

            # ------ following plan is wrong, because user may only modify one -----
            # a) find 2 sheet_versions, 
            # b) find responses in between the 2 sheets
            # c) replace 'responses' data with old version one. 
        else
          # render :action = > "index"
        end
     else
        forward_to_employee_form
     end
    
    #forward_to_employee_form
    
#    @previous_sheets = SurveySheet.find(:all, :conditions => ["user_id = :user_id ", 
#    { :user_id => self.current_user.id }  ] )
#    existing_ids = []
#    @previous_sheets.each { |s| existing_ids << s.survey_id }
#    @all_def = Survey.find(:all)
#    @available_surveys = [] 
#    
#    @all_def.each do | s |
#      @available_surveys << s  unless existing_ids.include?(s.id)
#    end
  end
  
#  def edit
#    if params[:id]
#      @survey_sheet = SurveySheet.find(:first, 
#                       :conditions => ["user_id = :user_id and survey_id = :survey_id", 
#                        { :user_id => self.current_user.id, 
#                          :survey_id => params[:id] }  ] )
#    else
#      render :text => "Can not edit without an id!"  
#    end
#  end    
  
  def print
    
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


