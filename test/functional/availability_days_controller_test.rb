require 'test_helper'

class AvailabilityDaysControllerTest < ActionController::TestCase
  setup do
    @availability_day = availability_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:availability_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create availability_day" do
    assert_difference('AvailabilityDay.count') do
      post :create, :availability_day => @availability_day.attributes
    end

    assert_redirected_to availability_day_path(assigns(:availability_day))
  end

  test "should show availability_day" do
    get :show, :id => @availability_day.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @availability_day.to_param
    assert_response :success
  end

  test "should update availability_day" do
    put :update, :id => @availability_day.to_param, :availability_day => @availability_day.attributes
    assert_redirected_to availability_day_path(assigns(:availability_day))
  end

  test "should destroy availability_day" do
    assert_difference('AvailabilityDay.count', -1) do
      delete :destroy, :id => @availability_day.to_param
    end

    assert_redirected_to availability_days_path
  end
end
