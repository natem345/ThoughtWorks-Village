require 'test_helper'

class MentorsControllerTest < ActionController::TestCase
  setup do
    @mentor = mentors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mentors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mentor" do
    assert_difference('Mentor.count') do
      post :create, :mentor => @mentor.attributes
    end

    assert_redirected_to mentor_path(assigns(:mentor))
  end

  test "should show mentor" do
    get :show, :id => @mentor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mentor.to_param
    assert_response :success
  end

  test "should update mentor" do
    put :update, :id => @mentor.to_param, :mentor => @mentor.attributes
    assert_redirected_to mentor_path(assigns(:mentor))
  end

  test "should destroy mentor" do
    assert_difference('Mentor.count', -1) do
      delete :destroy, :id => @mentor.to_param
    end

    assert_redirected_to mentors_path
  end
end
