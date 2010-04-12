require 'test_helper'

class TravelPlacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travel_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travel_place" do
    assert_difference('TravelPlace.count') do
      post :create, :travel_place => { }
    end

    assert_redirected_to travel_place_path(assigns(:travel_place))
  end

  test "should show travel_place" do
    get :show, :id => travel_places(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => travel_places(:one).id
    assert_response :success
  end

  test "should update travel_place" do
    put :update, :id => travel_places(:one).id, :travel_place => { }
    assert_redirected_to travel_place_path(assigns(:travel_place))
  end

  test "should destroy travel_place" do
    assert_difference('TravelPlace.count', -1) do
      delete :destroy, :id => travel_places(:one).id
    end

    assert_redirected_to travel_places_path
  end
end
