require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @password_reset = password_resets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:password_resets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create password_reset" do
    assert_difference('PasswordReset.count') do
      post :create, :password_reset => @password_reset.attributes
    end

    assert_redirected_to password_reset_path(assigns(:password_reset))
  end

  test "should show password_reset" do
    get :show, :id => @password_reset.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @password_reset.to_param
    assert_response :success
  end

  test "should update password_reset" do
    put :update, :id => @password_reset.to_param, :password_reset => @password_reset.attributes
    assert_redirected_to password_reset_path(assigns(:password_reset))
  end

  test "should destroy password_reset" do
    assert_difference('PasswordReset.count', -1) do
      delete :destroy, :id => @password_reset.to_param
    end

    assert_redirected_to password_resets_path
  end
end
