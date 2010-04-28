# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  # -----------------------------------------------------------------------------------
  def create_from_windows_login
    if !(login = forwarded_user)
      flash[:error] = "Browser did not provide Windows domain user name"
      logger.info "Browser did not provide Windows domain user name"
      user = nil
    elsif 1 == 2 #user = User.authenticated_by_windows_domain(login)
      # user has access rights to system
      logger.info "000000000000000000000000"
    else
      flash[:error] = "we can not use a sspi"                                                                                                                                                                                                                                                                                                                 
      logger.info "we can not use a sspi"
    end
    self.current_user = user
    if logged_in?
      # store that next time automatic login should be made
      cookies[:windows_domain] = {:value => 'true', :expires => Time.now + 1.month}
      # Because of IE NTLM strange behavior need to give 401 response with Javascript redirect
      @redirect_to = redirect_back_or_default_url(root_path)
      render :status => 401, :layout => 'redirect'
    else
      render :action => 'new'
    end
end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
  

#private
  def forwarded_user
    logger.error "#{request.headers}"
    return nil unless x_forwarded_user = request.headers['HTTP_X_REMOTE_USER_6E3RZQKX ']
    users = x_forwarded_user.split(',')
    users.delete('(null)')
    users.first
  end
end
