class AccountActivationsController < ApplicationController
   def edit
    user = User.find_by(email: params[:email])
    respond_to do |format|
      if user && !user.activated? 
        user.activate
        format.html{redirect_to :home, notice:'Account activated'}
      else
        format.html{redirect_to :home, notice:'invalid activation link'}
      end
    end
  end
end
