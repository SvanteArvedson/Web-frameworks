class ApplicationsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @application = Application.new(application_params)
    @application.user = @user
    
    if @application.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def destroy
    @application = Application.find(params[:id])
    @user = User.find(params[:user_id])
    
    if @application.user.id == @user.id
      @application.destroy
      redirect_to user_path(@user), status: 303
    else
      # add flash message
      # redirect to front page
    end
  end
  
  def new
    @user = User.find(params[:user_id])
    @application = Application.new
  end
  
  private
  # strong parameters
  def application_params
    params.require(:application).permit(:name, :application_type_id)
  end
  
end
