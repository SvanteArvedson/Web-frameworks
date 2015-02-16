class DevelopersController < ApplicationController
  before_action :require_login, only: [:destroy, :index, :show]
  before_action :require_logout, only: [:new, :create]
  
  # creates new developer
  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      session[:developerid] = @developer.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  # deletes developer
  def destroy
    @developer = Developer.find(params[:id])
    @developer.destroy
    redirect_to developers_path, status: 303
  end
  
  # lists all developers
  def index
    require_admin_login
    @developers = Developer.where(admin: false)
  end
  
  # renders new developer form
  def new
    @developer = Developer.new
  end
  
  # shows developer
  def show
    require_admin_or_developer_login_by(params[:id])
    @developer = Developer.find(params[:id])    
    @applications = @developer.applications
  end
  
  private
  
  # strong parameters
  def developer_params
    params.require(:developer).permit(:name, :email, :password, :password_confirmation)
  end
  
end