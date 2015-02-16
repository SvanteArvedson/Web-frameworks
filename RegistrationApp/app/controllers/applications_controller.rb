class ApplicationsController < ApplicationController
  before_action :require_login, only: [:create, :destroy, :new]
  
  def create
    require_admin_or_developer_login_by(params[:developer_id])
    @developer = Developer.find(params[:developer_id])
    @application = Application.new(application_params)
    @application.developer = @developer
    
    if @application.save
      flash[:success] = "New application created."
      redirect_to developer_path(@developer)
    else
      render 'new'
    end
  end
  
  def destroy
    require_admin_or_developer_login_by(params[:developer_id])
    @application = Application.find(params[:id])
    @developer = Developer.find(params[:developer_id])
    
    if @application.developer.id == @developer.id
      @application.destroy
      flash[:success] = "Application deleted."
      redirect_to developer_path(@developer), status: 303
    else
      flash[:danger] = "Not found."
      redirect_to root_path
    end
  end
  
  def new
    require_admin_or_developer_login_by(params[:developer_id])
    
    @developer = Developer.find(params[:developer_id])
    @application = Application.new
  end
  
  private
  # strong parameters
  def application_params
    params.require(:application).permit(:name, :application_type_id)
  end
  
end
