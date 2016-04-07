class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    respond_to do |format|
      if @user
        @user.create_reset_digest
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
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def user_params
    
    up = params.require(:user).permit(:password, :password_confirmation)
    up[:email_confirmation] = params[:email_confirmation]
    return up 

  end
  def get_user
    @user = User.find_by(email: params[:email])
  end
  # Confirms a valid user.
  def valid_user
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
