require 'test_helper'

class AvailabilityCalendarsControllerTest < ActionController::TestCase
  setup do
    @availability_calendar = availability_calendars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:availability_calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create availability_calendar" do
    assert_difference('AvailabilityCalendar.count') do
      post :create, :availability_calendar => @availability_calendar.attributes
    end

    assert_redirected_to availability_calendar_path(assigns(:availability_calendar))
  end

  test "should show availability_calendar" do
    get :show, :id => @availability_calendar.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @availability_calendar.to_param
    assert_response :success
  end

  test "should update availability_calendar" do
    put :update, :id => @availability_calendar.to_param, :availability_calendar => @availability_calendar.attributes
    assert_redirected_to availability_calendar_path(assigns(:availability_calendar))
  end

  test "should destroy availability_calendar" do
    assert_difference('AvailabilityCalendar.count', -1) do
      delete :destroy, :id => @availability_calendar.to_param
    end

    assert_redirected_to availability_calendars_path
  end
end
