class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  helper_method :current_user, :require_login, :require_admin_login 
  
  def current_user
    if session[:userid]
      @current_user ||= User.find(session[:userid])
    end
  end
  
  def require_login(user_id = 0)
    if current_user.nil? || (user_id != 0 && current_user.id != user_id)
      redirect_to root_path
    end
  end
  
  def require_admin_login
    if current_user.nil? || current_user.admin == false
      redirect_to root_path
    end
  end
  
  def require_logout
    unless current_user.nil?
      redirect_to root_path
    end
  end
end
