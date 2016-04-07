class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :ensure_valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    respond_to do |format|
      if @user
        @user.send_password_reset_email
        format.html { redirect_to :home, notice: 'Email sent with password reset instructions' }
      else
        format.html { redirect_to :new_password_reset, notice: 'Email address not found' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to :profile, notice: 'password was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

private
  def user_params
    
    up = params.require(:user).permit(:password, :password_confirmation)
    up[:email_confirmation] = params.require :email_confirmation
    return up 

  end
  def get_user
    @user = User.find_by(params.require :email)
  end
  # Confirms a valid user.
  def ensure_valid_user
    unless (@user && @user.activated?)
      redirect_to root_url
    end 
  end
  def check_expiration
    if @user.password_reset_expired?
      redirect_to new_password_reset_url
    end
  end
end
