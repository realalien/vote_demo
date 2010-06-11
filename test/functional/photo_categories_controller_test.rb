require 'test_helper'

class PhotoCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_category" do
    assert_difference('PhotoCategory.count') do
      post :create, :photo_category => { }
    end

    assert_redirected_to photo_category_path(assigns(:photo_category))
  end

  test "should show photo_category" do
    get :show, :id => photo_categories(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => photo_categories(:one).id
    assert_response :success
  end

  test "should update photo_category" do
    put :update, :id => photo_categories(:one).id, :photo_category => { }
    assert_redirected_to photo_category_path(assigns(:photo_category))
  end

  test "should destroy photo_category" do
    assert_difference('PhotoCategory.count', -1) do
      delete :destroy, :id => photo_categories(:one).id
    end

    assert_redirected_to photo_categories_path
  end
end
