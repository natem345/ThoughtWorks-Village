require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase
  setup do
    @experience = experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create experience" do
    assert_difference('Experience.count') do
      post :create, :experience => @experience.attributes
    end

    assert_redirected_to experience_path(assigns(:experience))
  end

  test "should show experience" do
    get :show, :id => @experience.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @experience.to_param
    assert_response :success
  end

  test "should update experience" do
    put :update, :id => @experience.to_param, :experience => @experience.attributes
    assert_redirected_to experience_path(assigns(:experience))
  end

  test "should destroy experience" do
    assert_difference('Experience.count', -1) do
      delete :destroy, :id => @experience.to_param
    end

    assert_redirected_to experiences_path
  end
end
