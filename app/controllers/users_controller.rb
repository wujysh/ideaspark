class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end

  def show
    @user = user_by_param_or_current 
  end

  def edit
    @user = user_by_param_or_current 
  end

  def update
    @user = user_by_param_or_current
    if @user.update_attributes(user_params)
      redirect_to @user, :flash => { :success => "Profile updated" }
    else
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to IdeaSpark."
      redirect_back_or root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = user_by_param_or_current 
      redirect_to root_path unless current_user?(@user)
    end

    def user_by_param_or_current
      !params[:id].nil? ? User.find(params[:id]) : current_user
    end
end
