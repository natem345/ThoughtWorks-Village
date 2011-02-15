require 'test_helper'

class MentorshipsControllerTest < ActionController::TestCase
  setup do
    @mentorship = mentorships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mentorships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mentorship" do
    assert_difference('Mentorship.count') do
      post :create, :mentorship => @mentorship.attributes
    end

    assert_redirected_to mentorship_path(assigns(:mentorship))
  end

  test "should show mentorship" do
    get :show, :id => @mentorship.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mentorship.to_param
    assert_response :success
  end

  test "should update mentorship" do
    put :update, :id => @mentorship.to_param, :mentorship => @mentorship.attributes
    assert_redirected_to mentorship_path(assigns(:mentorship))
  end

  test "should destroy mentorship" do
    assert_difference('Mentorship.count', -1) do
      delete :destroy, :id => @mentorship.to_param
    end

    assert_redirected_to mentorships_path
  end
end
