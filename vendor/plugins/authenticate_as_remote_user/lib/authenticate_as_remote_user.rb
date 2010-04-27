# AuthenticateAsRemoteUser
# 
# This plugin provides a simple intereface to various Apache authentication systems to allow your
# Rails application to find out the currently logged in user.  The plugin interface is similar to the 
# Acts As Authenticated plugin, but it does no actual authentication.
# 
# Apache authentication modules set the REMOTE_USER variable to the user name that the user used to 
# authenticate themselves.  This variable is passed to CGI and FastCGI applications as is.
# 
# For proxy applications, e.g. mongrel, you need to write some nifty Rewrite rules to transfer the 
# value of REMOTE_USER to your own variable:
# 
# Example:
# 
#   RewriteEngine On
#   RewriteCond %{LA-U:REMOTE_USER} (.+)
#   RewriteRule .* - [E=RU:%1]
#   RequestHeader add REMOTE_USER %{RU}e
# 
# Here's what this Rewrite-fu does:
# 
# Line 2: Use lookahead access to get REMOTE_USER set by authentication module
# Line 3: Transfer the results of line 2 into an environment variable called RU
# Line 4: Set a Request header to the environment variable from line 3.
# 
# In the proxy case, the prefix HTTP_ will be added, so the variable in your app will be 
# HTTP_REMOTE_USER.  You can override the default remote_property_name method in your code to
# allow for this case.
# 
# 
# Usage:
# 
#   1. Install plugin
#   2. include RemoteUser into controllers that need it
#   3. Implement the find_user method to load your user model
#   4. Implement the access_denied! method
#   5. Implement before_filter for login_required for actions you want to protect
#   6. Optionally implement remote_property_name to match your Apache configuration
#   
# ==== Install plugin
# 
#   script/plugin install authenticate_as_remote_user
#   rake test:plugins PLUGIN=authenticate_as_remote_user
#   
# ==== Include RemoteUser into controllers
# 
# Example:
# 
#   class ApplicationController < ActionController::Base
#     include RemoteUser
#     ...
#     
# ==== Implement the find_user method to load your user model
# 
# Example:
# 
#   class ApplicationController < ActionController::Base
#     include RemoteUser
#     
#     def find_user(remote_name)
#       User.find_by_name(remote_name)
#     end
#    
# ==== Imeplement the access_denied method
# 
# Example
# 
#   def access_denied!
#     redirect_to access_denied_path and return false
#   end
#   
# ==== Implement before_filter for login_required for actions you want to protect
# 
# Example:
# 
#   class SomeController < ApplicationController
#   
#       before_filter :login_required, :only => [ :update, create, destroy ]
# 
# ==== Optionally implement remote_property_name to match your Apache configuration
# 
# Example
# 
#   def remote_property_name
#     "HTTP_REMOTE_USER"
#   end
#   
module RemoteUser
  protected
    # Returns true or false if the user is logged in.
    def logged_in?
      current_user != nil
    end

    # Use login_required in a before_filter for those actions that need a user to
    # be authenticated
    # 
    # Example:
    # 
    #   before_filter :login_required 
    #
    def login_required
      @current_user = find_user(request.env[remote_property_name])
      access_denied! unless logged_in? 
    end    
    
    # Accesses the current user from the session.
    def current_user
      @current_user
    end

    # Is the supplied user the currently logged in user?
    def current_user?(other_user)
      other_user == current_user
    end

    # Override this to return the property name you have used in Apache
    #
    # Defaults to REMOTE_USER, but if you have Apache proxy the request, this
    # will need to be HTTP_REMOTE_USER (or whatever you set in your httpd.conf
    # 
    def remote_property_name
      "REMOTE_USER"
    end
    
    # Override to load the current_user from your user database
    # 
    # Example:
    # 
    # def find_user(remote_name)
    #   current_user = User.find_by_name(remote_name)
    # end
    # 
    def find_user(remote_name)
      nil
    end
    
    # Check if the user is authorized.
    #
    # Override this method in your controllers if you want to restrict access
    # to only a few actions or if you want to check if the user
    # has the correct rights.
    #
    # Example:
    #
    #  # only allow nonbobs
    #  def authorize?
    #    current_user.login != "bob"
    #  end
    def authorized?
      true
    end

    # Redirect as appropriate when an access request fails.
    #
    # Override this method in your controllers if you want to have special
    # behavior in case the User is not authorized
    # to access the requested action.  For example, a popup window might
    # simply close itself.
    def access_denied!
      false
    end    
end
