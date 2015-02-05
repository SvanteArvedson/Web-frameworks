class SessionsController < ApplicationController
  before_action :require_logout, only: [:create, :new]

  def create
    user = User.find_by_email(params[:session][:email])
    unless user
      user = User.find_by_name(params[:session][:email])
    end
   
    if user && user.authenticate(params[:session][:password])
      login_user user
      flash[:success] = "Successfully logged in."
    else
      flash[:danger] = "Wrong credentials."
    end
    
    redirect_to root_path
  end
  
  def destroy
    logout_user
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
  
  def index
    if logged_in?
      @users = User.all
      render 'users/index'
    else
      render 'new'
    end
  end

  def new
  end

end