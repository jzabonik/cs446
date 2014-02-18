require 'test_helper'

class FostersControllerTest < ActionController::TestCase
  setup do
    @foster = fosters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fosters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foster" do
    assert_difference('Foster.count') do
      post :create, foster: { 
		@animals = animals(:monkey)
	  }
    end

    assert_redirected_to foster_path(assigns(:foster))
  end

  test "should show foster" do
    get :show, id: @foster
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @foster
    assert_response :success
  end

  test "should update foster" do
    patch :update, id: @foster, foster: {  }
    assert_redirected_to foster_path(assigns(:foster))
  end

  test "should destroy foster" do
    assert_difference('Foster.count', -1) do
      delete :destroy, id: @foster
    end

    assert_redirected_to fosters_path
  end
end
