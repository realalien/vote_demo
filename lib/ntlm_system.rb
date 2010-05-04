module NtlmSystem
protected
# Returns true or false if the user is logged in.
# Preloads @current_user with the user model if they're logged in.
def logged_in?
if session[:logged_in].nil?
return false
end
if session[:logged_in] == :false
return false
end
return true
end

def login_required
if logged_in?()
return
end
pp "Access Denied"
access_denied()
end

# Redirect as appropriate when an access request fails.
# Our application only uses ntlm based login - you must be part of the domain
def access_denied
redirect_to('/ntlm/login')
end 

# Store the URI of the current request in the session.
#
# We can return to this location by calling #redirect_back_or_default.
def store_location
session[:return_to] = request.request_uri
end

# Redirect to the URI stored by the most recent store_location call or
# to the passed default.
def redirect_back_or_default(default)
session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(default)
session[:return_to] = nil
end
end