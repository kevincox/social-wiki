class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /signup
  def signup
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)



    respond_to do |format|
      if field_empty?        
        format.html { redirect_to :signup , notice: 'please fill all the fields.'}
      else
        if !pass_confirm?        
          format.html { redirect_to :signup , notice: 'password does not match.'}
        else
          if user_exits?
            format.html { redirect_to :signup, notice: 'username or email already exists.' }
          else
            if @user.save
              format.html { redirect_to @user, notice: 'User was successfully created.' }
              format.json { render :show, status: :created, location: @user }
            else
              format.html { render :new }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    end

  end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #used to compare the users desired passwords
  def pass_confirm?
    confirm_flag = false
    if @user[:password] == confirm_password[:confirm_password] 
        confirm_flag = true  
    end
    return confirm_flag
  end
  def user_exits?
    exist_flag = false
    if @user.lookup_username(@user[:username]) != nil || @user.lookup_email(@user[:email]) != nil
      exist_flag = true
    end
    return exist_flag
  end
  def field_empty?
    empty_flag = false
    if @user[:username].blank? || @user[:email].blank? || @user[:password].blank?  
      empty_flag = true
    end
    return empty_flag

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :email)
    end

    def confirm_password
      params.require(:user).permit(:confirm_password)
    end
end
