class SessionsController < ApplicationController
  before_action :require_logout, only: [:create, :new]
  before_action :require_login, only: [:destroy]

  def create
    developer = Developer.find_by_email(params[:session][:email])
    unless developer
      developer = Developer.find_by_name(params[:session][:email])
    end
   
    if developer && developer.authenticate(params[:session][:password])
      login_developer developer
      flash[:success] = "Successfully logged in."
    else
      flash[:danger] = "Wrong credentials."
    end
    
    redirect_to root_path
  end
  
  def destroy
    logout_developer
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
  
  def index
    if logged_in?
      if admin_logged_in?
        @developers = Developer.all
        render 'developers/index'
        return
      end
      @developer = current_developer
      @applications = @developer.applications
      render 'developers/show'
    else
      render 'new'
    end
  end

  def new
  end

end