require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get login," do
    get :login
    assert_response :success
  end

  test "should have a successfull login attempt with username" do
    post :login_attempt, username_or_email: 'user1', login_password: 'password1'
    assert_equal session[:user_id], users(:user1).id
    assert_redirected_to :home
  end

  test "should have a successfull login attempt with email" do
    post :login_attempt, username_or_email: 'user1@email.ca', login_password: 'password1'
    assert_equal session[:user_id], users(:user1).id
    assert_redirected_to :home
  end

  test "should not have a successfull login attempt with wrong password" do
    post :login_attempt, username_or_email: 'user1@email.ca', login_password: 'password3'
    refute_equal session[:user_id], users(:user1).id
    refute session[:user_id]
    assert_redirected_to :login
  end

  test "should logout and have no one as session" do
    get :logout
    refute session[:user_id]
    assert_redirected_to :home
  end

  test "should get home," do
    get :home
    assert_response :success
  end

  test "should get profile," do
    session[:user_id] = users(:user1).id
    get :profile
    assert_redirected_to users :user1
  end

  test "should get setting" do
    session[:user_id] = users(:user1).id
    get :setting
    assert_response :success
  end

end
