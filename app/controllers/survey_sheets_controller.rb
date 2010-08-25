# TODO: if new questions is added to a survey, survey_sheet should reflect those newly created ones. 


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
    if params[:id]
      @survey_sheet = SurveySheet.find_by_id(params[:id], :include => :responses)
      logger.debug "==============================================================="
      logger.debug "For this survey_sheet, id: #{@survey_sheet.id}, "
      logger.debug "corresponding survey defination id: ........ #{@survey_sheet.survey_id}"
      
      q_ids_in_def = Survey.find_by_id(@survey_sheet.survey_id).questions.collect(&:id) || []
      logger.debug "questsion ids ( in survey definition ) ........ #{q_ids_in_def.join(",")}"
      
      q_ids_in_sheet = @survey_sheet.questions.collect(&:id) || []
      logger.debug "questsion ids ( in survey sheet ) ........ #{q_ids_in_sheet.join(",")}"
      
      q_ids_in_responses = @survey_sheet.responses.collect(&:question_id) || []
      logger.debug "question ids ( in sheet responses) ........ #{q_ids_in_responses.join(",")}"
      
      
      # check if the survey definition has changed. Scenarions includes "Deleted", "Added"
      # TODO: counting is NOT safe, e.g. removed one and adding one, must use id
      # TODO: make it in one transaction.
      
      
      # ATTENTION, because the many-to-many relations for the model
      #  survey<->questions  ( via table survey_question_assignments), 
      #  and survey_sheet<->questions   ( via table sheet_question_relations)
      #  any unsynchronized modification may cause troubles, 
      #  So, when handling difference, be aware of the relation used.(e.g. create new obj. only when necessary.)
      #  * the applying rule is survey_def is first consideration, sheet the second
      #    handling response last.
      #  * maybe the test cases will be very useful.


      # ESP. preempt action for such scenario, adding new 
      if (q_ids_in_sheet <=> q_ids_in_def ) == -1  # sheet has less questions than definition.
           logger.debug "----  sheet has less questions than defination! "
           diff = q_ids_in_def - q_ids_in_sheet
           logger.debug "ids: #{diff.join(",")}"  
           logger.debug "-----------------------------------------"
           diff.each do | d |
               @survey_sheet.questions << Question.find_by_id(d)
           end
           @survey_sheet.save!
      elsif  (q_ids_in_sheet <=> q_ids_in_def ) == 1 # sheet has more questions than definition.
          (q_ids_in_sheet - q_ids_in_def ).each do | q |
              @survey_sheet.delete(q)
          end
      end
      
      # Q: do I need this step?
      q_ids_in_sheet = @survey_sheet.questions.collect(&:id) || []
      logger.debug "questsion ids ( in survey sheet, after resync sheet to def.) ........ #{q_ids_in_sheet.join(",")}"

      # ESP. preempt action for such scenario, the survey<->questions definition NOT changed, but the response was removed.
      if ( q_ids_in_responses <=> q_ids_in_sheet ) == -1 # response haswith less records  
          logger.debug "----  Found new questions,  added to the survey_sheet! "
          diff = q_ids_in_sheet - q_ids_in_responses
          logger.debug "ids: #{diff.join(",")}"
          logger.debug "-----------------------------------------"
          
          logger.debug "---------      sheet.questions.size .... #{@survey_sheet.questions.size} .... before creating responses"
          # add responses (TODO: with null value? )           
          # TODO: not current_user, should be user being inspected, e.g. when a user is inspected by admin
          @survey_sheet.questions.each do | q |
            if not q_ids_in_responses.include? q.id
              r = handmade_response(@survey_sheet.id, q.id, self.current_user.id )  
              @survey_sheet.responses << r
            end
          end
          @survey_sheet.save!
          logger.debug "---------      sheet.questions.size .... #{@survey_sheet.questions.size} .... after creating responses"
          logger.debug "---------      sheet.responses.size .... #{@survey_sheet.responses.size} .... after creating responses"
      elsif ( q_ids_in_responses <=> q_ids_in_sheet ) == 1     
          # clean responses
          logger.debug " !!!!!  going to remove responses data"
          # not delete, keep it, at most the relation can be delete if there will be a intermediate table.
      end
      
      # INFO: it looks like that we should employ more privilege control over object model, otherwise more hard code required
      if current_user.id != @survey_sheet.user.id
         if current_user.has_role(:leader)
            flash[:notice] = "You are viewing #{@survey_sheet.user.login}'s survey! Be careful when editing!"      
            render :action => "edit"
         else
            flash[:notice] = "You are not allowed to view other's survey! Go back to your own one!"
         end
      else  
          render :action => "edit"  
      end
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
        :survey_id => params[:survey_id] } ]) 
      
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
          r = handmade_response(@survey_sheet.id, question.id, self.current_user.id )
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
  
  
  # TODO: should be private
  def handmade_response(sheet_id, question_id, user_id)
     r = Response.new()
     r.survey_sheet_id = sheet_id
     r.question_id = question_id
     r.user_id = user_id
     return r
  end
  
  # PUT /survey_sheets/1
  # INFO: we don't stop user from editing others' survey, user will not reach edit page depends on 
  def update
    # TODO: try to retrieve the survey_sheet then update, avoid hacking by faking a id of non-self survey_sheet
    
    if (has_survey_responses(params))
      #render :text => "in update, params has responses, so we can parse and update!"
      # * parse and update the survey_sheet and responses, see if we can DRY by doing sth 
      #   in helper or rails multiple model updating
      sheet_id = params["id"]
      survey_id = params["survey_id"]
      
#      @survey_sheet = SurveySheet.find(:first, :include =>:responses ,:conditions => ["user_id = :user_id and survey_id = :survey_id", 
#      { :user_id => self.current_user.id, :survey_id => survey_id }  ] )
      
       @survey_sheet = SurveySheet.find(:first, :include =>:responses ,:conditions => ["id = :sheet_id", 
      { :sheet_id => sheet_id }  ] )
      
      logger.debug "==============================================================="
      logger.debug "@survey_sheet info:  #{@survey_sheet.id}"
      logger.debug "@survey_sheet has responses size:  #{@survey_sheet.responses.size}"
      
      # TODO: make it a transaction to avoid dirty records
      ts = Time.now
      
      # esp, delete method will rerturn nil instead of processed array
      prev_vers = @survey_sheet.sheet_histories.collect(&:version_num)
      prev_vers.delete(nil)
      if prev_vers and not prev_vers.empty? # select the max and then plus one   
        current_ver =  prev_vers.max + 1
      else  # assign 1 to the first
        current_ver = 1
      end
      
      # create a sheet version entry
      @a_version = SheetHistory.new
      @a_version.version_num = current_ver
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
      render :text => "There is no response for this survey sheet!"
    end
  end
  
  # TODO: study the resourceful design and make the index action right
  # DOING: allow user to display a previous version.
  def index
     
     # @survey_sheet = find_user_employee_form
     
     # make leader see other employee's 
     if params[:user_id] and current_user.has_role("leader")
        viewing_user = User.find_by_id(params[:user_id])  # sanity check.
        if viewing_user
          flash[:notice] = "You are viewing others survey"
          @survey_sheet = SurveySheet.find(:conditions => ["user_id = ? and response_id = ? and updated_at <= ? ", viewing_user.id, resp.id , timestamp_end_version ], :order => "updated_at DESC" )   #          
        else
          viewing_user = current_user 
          @survey_sheet = find_user_employee_form
        end
     else  
        viewing_user = current_user 
        @survey_sheet = find_user_employee_form 
     end

     # replace the 
     if @survey_sheet
        if params[:version_num]
            # load responses' previous version to get make page object displaying old versions.
            # the query criterior is:
            timestamp_end_version = SheetHistory.find_by_version_num(params[:version_num]).when_submit
            # ------ the right way is ------
            # to get all the responses which with 
            response_ids = []
            old_responses = {}
            
            # ESP.TODO: following code makes maintenance very hard! Find another way!
            @survey_sheet.responses.each do | resp |
              # response_ids << resp.id
              old = ResponseVersion.find(:first, :conditions => ["user_id = ? and response_id = ? and updated_at <= ? ", viewing_user.id, resp.id , timestamp_end_version ], :order => "updated_at DESC" )
              logger.debug "---------------------------- #{resp}"
              logger.debug "---------------------------- #{old}"
              # ESP. just for viewing, not 
              if not old
                  old = ResponseVersion.find(:first, :conditions => ["user_id = ? and response_id = ?  ", viewing_user.id, resp.id ], :order => "updated_at ASC" )
                  resp.rating = old.rating ; resp.answer_text = old.answer_text ;
              else  # as uausally #ESP.TODO  the first version not collect correctly.
                  resp.rating = old.rating ; resp.answer_text = old.answer_text ;
              end
               
            end
            
            # ------ following plan is wrong, because user may only modify one -----
            # a) find 2 sheet_versions, 
            # b) find responses in between the 2 sheets
            # c) replace 'responses' data with old version one. 
        else
          # render self 
          # render :action = > "index"
        end
     else
        forward_to_employee_form
     end
    
  end

  
  def history
    if params[:id]
        @survey_sheet = SurveySheet.find_by_id(params[:id])
        
        logger.debug "------------------------------------"
        logger.debug "@survey_sheet.responses.size is #{@survey_sheet.responses.size}"
  
        ver_num = params[:version]
        @survey_sheet.reload_history_by_version_num(ver_num)
        
        
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


