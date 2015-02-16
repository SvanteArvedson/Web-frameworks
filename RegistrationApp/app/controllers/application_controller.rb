class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_developer, :logged_in?, :admin_logged_in?, :require_login
  
  private
  
  def current_developer
    if session[:developerid]
      @current_developer ||= Developer.find(session[:developerid])
    end
  end
  
  def login_developer(developer)
    session[:developerid] = developer.id
  end
  
  def logout_developer
    session[:developerid] = nil
    @current_developer = nil
  end
  
  def logged_in?
    not current_developer.nil?
  end
  
  def admin_logged_in?
    if logged_in?
      current_developer.admin
    end
  end
  
  def require_login
    unless logged_in?
      flash[:danger] = "Must be logged in."
      redirect_to root_path
    end
  end
  
  def require_admin_or_developer_login_by(id)
    unless admin_logged_in?
      if id.to_f != current_developer.id
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
    unless current_developer.nil?
      flash[:danger] = "Must be logged out."
      redirect_to root_path
    end
  end
end
