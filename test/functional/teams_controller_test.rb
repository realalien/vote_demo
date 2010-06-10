require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teams" do
    assert_difference('Teams.count') do
      post :create, :teams => { }
    end

    assert_redirected_to teams_path(assigns(:teams))
  end

  test "should show teams" do
    get :show, :id => teams(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => teams(:one).id
    assert_response :success
  end

  test "should update teams" do
    put :update, :id => teams(:one).id, :teams => { }
    assert_redirected_to teams_path(assigns(:teams))
  end

  test "should destroy teams" do
    assert_difference('Teams.count', -1) do
      delete :destroy, :id => teams(:one).id
    end

    assert_redirected_to teams_path
  end
end
