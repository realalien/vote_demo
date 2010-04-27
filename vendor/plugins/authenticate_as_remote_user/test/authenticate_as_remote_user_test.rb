require "#{File.dirname(__FILE__)}/../../../../config/boot.rb"
require "#{File.dirname(__FILE__)}/../../../../config/environment.rb"

require 'action_controller/test_process'
require 'test/unit'

class RemoteUserController < ActionController::Base

  include RemoteUser
  before_filter :login_required, :only => [ :login_needed ]
    
  def no_login_needed
    render :text => "Action - No Login Needed"
  end
  
  def login_needed
    render :text => "Action - No Login Needed"
  end
  
protected
  def find_user(remote_user)
    { :name => remote_user } if remote_user == 'fake-user'
  end

  def access_denied!
    redirect_to '/access_denied' and return false
  end  
end

class AuthenticateAsRemoteUserTest < Test::Unit::TestCase
  def setup
    @controller = RemoteUserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_no_login_needed
    get :no_login_needed
    assert_response :success
    assert_nil current_user, "Current user should not be loaded"
  end
  
  def test_login_needed_not_logged_in
    get :login_needed
    assert_response :redirect
    assert_nil current_user, "Current user should not be loaded"
  end

  def test_login_needed_logged_in
    fake_login
    get :login_needed
    assert_response :success
    assert_not_nil current_user, "Current user should be loaded"
    assert_equal current_user[:name], 'fake-user'
  end
  
protected
  def fake_login()
    @request.env['REMOTE_USER'] = 'fake-user'
  end
  
  # current_user is protected
  def current_user
    @controller.send('current_user')
  end
end
