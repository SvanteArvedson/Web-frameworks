class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  private
  
  def encodeJWT(obj)
    return JWT.encode(obj, Rails.application.secrets.secret_key_base, "HS512")
  end
end
