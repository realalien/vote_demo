class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  #require_role "admin", :for => :index
  #require_role "admin"

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      # create default role for user
      employee_role = Role.find_by_name("employee")
      if employee_role and @user.respond_to? "roles"
        @user.roles << employee_role unless @user.roles.include? employee_role
      end
      forward_to_employee_form # redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!" #   We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def vote_for
	   current_user.vote_for(TravelPlace.find(params[:id]))
  end

  def index
    @users = User.find(:all)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    params[:user][:role_ids] ||= []
    @user = User.find(params[:id])
    
    # alway make 'employee' role effective. This code may amend formerly created data which has not been assigned
    if params[:user][:role_ids]
      params[:user][:role_ids] << 3
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
