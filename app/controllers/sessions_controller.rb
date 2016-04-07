class SessionsController < ApplicationController
  def login
  end
  def login_attempt
    authorized_user = User.authenticate_with_username_or_email(login_attempt_params[:username_or_email],login_attempt_params[:login_password])
    respond_to do |format|
      if authorized_user
        session[:user_id] = authorized_user.id
        format.html{ redirect_to :home, notice: 'Hey welcome in buddy' }
      else
        format.html{ redirect_to :login, notice: "oops, invalid username or password" }
      end
    end
  end

  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html{ redirect_to :home, notice: 'Logged out, see ya later bud!'}
    end
  end

  def home
  end
  def profile 
    current_user   
  end

  def setting
  end

private

  def login_attempt_params
    params.permit(:username_or_email,:login_password)
  end
end
