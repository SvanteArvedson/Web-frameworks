class UsersController < ApplicationController
  
  def create
    @user = User.new(user_params)
    if @user.save
      # add redirect here
    else
      render 'new'
    end
  end
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @applications = @user.applications
  end
  
  private
  def user_params
    params.require(:user).permit(:email)
  end
  
end
