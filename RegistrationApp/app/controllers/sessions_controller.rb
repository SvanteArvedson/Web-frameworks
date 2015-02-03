class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:session][:email])
    unless user
      user = User.find_by_name(params[:session][:email])
    end
    if user && user.autenticate(params[:session][:password])
      session[:userid] = user.id
    else
      # add flash message
    end
    
    redirect_to root_path
  end
  
  def destroy
    session[:userid] = nil
    # add flash message
    redirect_to root_path
  end
  
  def index
    render 'new'
  end

  def new
  end

end