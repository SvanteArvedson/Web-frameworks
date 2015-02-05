class UsersController < ApplicationController
  before_action :require_login, only: [:index]
  
  # creates new user
  def create
    @user = User.new(user_params)
    if @user.save
      session[:userid] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  # deletes user
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, status: 303
  end
  
  # lists all users
  def index
    @users = User.all
  end
  
  # renders new user form
  def new
    @user = User.new
  end
  
  # shows user
  def show
    @user = User.find(params[:id])
    @applications = @user.applications
  end
  
  private
  
  # strong parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end