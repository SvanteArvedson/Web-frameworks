class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :admin_logged_in?, :require_login
  
  private
  
  def current_user
    if session[:userid]
      @current_user ||= User.find(session[:userid])
    end
  end
  
  def login_user(user)
    session[:userid] = user.id
  end
  
  def logout_user
    session[:userid] = nil
    @current_user = nil
  end
  
  def logged_in?
    not current_user.nil?
  end
  
  def admin_logged_in?
    if logged_in?
      current_user.admin
    end
  end
  
  def require_login
    unless logged_in?
      flash[:danger] = "Must be logged in."
      redirect_to root_path
    end
  end
  
  def require_admin_or_user_login_by(id)
    unless admin_logged_in?
      if id.to_f != current_user.id
        flash[:danger] = "Not for you."
        redirect_to root_path
      end
    end
  end
  
  def require_admin_login
    unless admin_logged_in?
      flash[:danger] = "Must be administrator."
      redirect_to root_path
    end
  end
  
  def require_logout
    unless current_user.nil?
      flash[:danger] = "Must be logged out."
      redirect_to root_path
    end
  end
end
