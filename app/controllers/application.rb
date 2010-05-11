# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  layout "site"
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9086dd55d844edef4f232916f64fa66a'
  
  include AuthenticatedSystem
  
  #include Smerf, no use theirs

  # from link http://mentalpagingspace.blogspot.com/2008/12/rails-to-windows-integration-single.html
  # it looks like a session handling code, other function not demonstrated.
  #include NtlmSystem  


  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
