class ApplicationsController < ApplicationController
  before_action :require_login, only: [:create, :destroy, :new]
  
  def create
    require_admin_or_user_login_by(params[:user_id])
    @user = User.find(params[:user_id])
    @application = Application.new(application_params)
    @application.user = @user
    
    if @application.save
      flash[:success] = "New application created."
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def destroy
    require_admin_or_user_login_by(params[:user_id])
    @application = Application.find(params[:id])
    @user = User.find(params[:user_id])
    
    if @application.user.id == @user.id
      @application.destroy
      flash[:success] = "Application deleted."
      redirect_to user_path(@user), status: 303
    else
      flash[:danger] = "Not found."
      redirect_to root_path
    end
  end
  
  def new
    require_admin_or_user_login_by(params[:user_id])
    
    @user = User.find(params[:user_id])
    @application = Application.new
  end
  
  private
  # strong parameters
  def application_params
    params.require(:application).permit(:name, :application_type_id)
  end
  
end
