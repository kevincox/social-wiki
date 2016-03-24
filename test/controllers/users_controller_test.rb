require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	
  test "should sign up properly"  do
    assert_difference('User.count') do
      post :create, user: {username: 'user3',email:'user3@email.ca', password:'password3', password_confirmation:'password3'} 
    end
    assert session[:user_id] == User.find_by_username('user3').id  
    assert_redirected_to :home
  end

  test "should not be able to sign up with a username already existing" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user2',email:'user3@email.ca', password:'password3', password_confirmation:'password3'} 
    end
    refute session[:user_id] == User.find_by_username('user2').id  
  end
  test "should not be able to sign up with a email already existing" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user3',email:'user2@email.ca', password:'password3', password_confirmation:'password3'} 
    end
    refute session[:user_id] == User.find_by_email('user2@email.ca').id  
  end
  test "should not be able to sign up with no confirming password" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user3',email:'user3@email.ca', password:'password2', password_confirmation:'password1'} 
    end
    refute session[:user_id] 
  end
  test "should not be able to sign up with a missing username" do
    assert_difference('User.count',0) do
      post :create, user: {username: '',email:'user3@email.ca', password:'password3', password_confirmation:'password3'} 
  end
    refute session[:user_id]  
  end
  test "should not be able to sign up with a missing email" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user3',email:'', password:'password3', password_confirmation:'password3'} 
    end
    refute session[:user_id] 
  end
  test "should not be able to sign up with a bad email format" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user3',email:'user3emailca', password:'password3', password_confirmation:'password3'} 
      post :create, user: {username: 'user3',email:'user3email.ca', password:'password3', password_confirmation:'password3'} 
      post :create, user: {username: 'user3',email:'user3@emailca', password:'password3', password_confirmation:'password3'} 
    end
    refute session[:user_id]  
  end
  test "should not be able to sign up with a missing password" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user3',email:'user3@email.ca', password:'', password_confirmation:'password3'} 
      post :create, user: {username: 'user3',email:'user3@email.ca', password:'password3', password_confirmation:''} 
    end
    refute session[:user_id]  
  end
  test "should not be able to sign up with a password that is too short" do
    assert_difference('User.count',0) do
      post :create, user: {username: 'user3',email:'user3@email.ca', password:'sss', password_confirmation:'sss'} 
    end
    refute session[:user_id]
  end
end
