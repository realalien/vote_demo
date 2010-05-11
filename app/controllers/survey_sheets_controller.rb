
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
    if (has_survey_responses(params))
      #render :text => "in update, params has responses, so we can parse and update!"
      # * parse and update the survey_sheet and responses, see if we can DRY by doing sth 
      #   in helper or rails multiple model updating
      sheet_id = params["id"]
      survey_id = params["survey_id"]
      
      @survey_sheet = SurveySheet.find(:first, :include =>:responses ,:conditions => ["user_id = :user_id and survey_id = :survey_id", 
      { :user_id => self.current_user.id, :survey_id => survey_id }  ] )
      
      logger.debug "@survey_sheet has responses size:  #{@survey_sheet.responses.size}"
      
      @survey_sheet.responses.each do | response | 
        response.update_attribute(:updated_at ,Time.now)
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
    if params[:id]
      @survey_sheet = SurveySheet.find(:first, 
                       :conditions => ["user_id = :user_id and survey_id = :survey_id", 
                        { :user_id => self.current_user.id, 
                          :survey_id => params[:id] }  ] )
    else
      render :text => "Can not edit without an id!"  
    end
  end    
  
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


