# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  layout "site"
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9086dd55d844edef4f232916f64fa66a'
  
  include AuthenticatedSystem
  
  # TEMP_USE
  # see bug#1770, the user should take the 'employee form' survey supposing we have only one survey at the moments.
  # this method should later be deprecated when there is more than one survey.
  def forward_to_employee_form
      if logged_in?
          @survey_sheet = find_user_employee_form
          if  @survey_sheet
              redirect_to survey_sheet_path(@survey_sheet.id)
          else
              survey_defs = find_user_employee_form
              if survey_defs
                redirect_to new_survey_sheet_path(:survey_id => survey_defs.id )
              else
                render :text => "You're supposed to take the survey named 'Spicy Horse Quarterly Teammate Evaluation Form', but it's not available right now! Contact IT dept. "     
              end
          end
      else
          redirect_to login_path
      end
  end

  def find_user_employee_form
    survey_defs = Survey.find_by_title("Spicy Horse Quarterly Teammate Evaluation Form")
    if survey_defs
        survey_sheet = SurveySheet.find(:first, 
            :conditions => ["user_id = :user_id and survey_id = :survey_id" , 
            { :user_id => self.current_user.id, 
              :survey_id => survey_defs.id } ])
        if survey_sheet 
            return survey_sheet
        else
            return nil
        end
    else
        logger.debug "Not found any survey with title 'Spicy Horse Quarterly Teammate Evaluation Form'"
        return nil
    end
  end

  #redirect_to survey_sheets_url
  #redirect_back_or_default('/')
  
  #include Smerf, no use theirs

  # from link http://mentalpagingspace.blogspot.com/2008/12/rails-to-windows-integration-single.html
  # it looks like a session handling code, other function not demonstrated.
  #include NtlmSystem  


  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
end
