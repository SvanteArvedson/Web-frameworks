class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  private
  
  def encodeJWT(obj)
    return JWT.encode(obj, Rails.application.secrets.secret_key_base, "HS512")
  end
  
  def decodeJWT(jwt)
    return JWT.decode(jwt, Rails.application.secrets.secret_key_base, "HS512")
    # TODO: if error is raised, render error message
  end
  
  def require_api_key
    unless Application.exists?(api_key: params['api_key'])
      render json: ErrorMessage.new("Unvalid api_key.", "An error occured when making the request. Contact the application owner."), status: :bad_request
    end
  end
  
  def require_auth_token
    if params['auth_token'].nil?
      render json: ErrorMessage.new("Unexisting auth_token.", "An error occured when making the request. Contact the application owner."), status: :bad_request
    end
    
    decoded_auth_token = decodeJWT(params['auth_token'])
    
    unless Creator.exists?(id: decoded_auth_token[0]['creator_id']) && Time.now.utc < decoded_auth_token[0]['terminates_at']
      render json: ErrorMessage.new("Unvalid auth_token.", "You must log in to do make this request."), status: :unauthorized
    end

  end
  
end
