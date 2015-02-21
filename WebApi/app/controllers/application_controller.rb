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
    if params['api-key'].nil? && request.headers['Api-Key'].nil?
      render json: ErrorMessage.new("Unexisting api-key.", "An error occured when making the request. Contact the application owner."), status: :bad_request
      return
    else
      api_key = params['api-key'].present? ? params['api-key'] : request.headers['api-key']
    end
    
    unless Application.exists?(api_key: api_key)
      render json: ErrorMessage.new("Unvalid api-key.", "An error occured when making the request. Contact the system administrator."), status: :bad_request
    end
  end
  
  def require_auth_token
    if params['auth-token'].nil? && request.headers['auth-Token'].nil?
      render json: ErrorMessage.new("Unexisting auth-token.", "An error occured when making the request. Contact the application owner."), status: :bad_request
      return
    else
      auth_token = params['auth-token'].present? ? params['auth-token'] : request.headers["auth-token"]
    end
    
    decoded_auth_token = decodeJWT(auth_token)[0]
    
    unless Creator.exists?(id: decoded_auth_token['creator_id']) && Time.now.utc < decoded_auth_token['terminates_at']
      render json: ErrorMessage.new("Unvalid auth_token.", "You must log in to do make this request."), status: :unauthorized
    end
  end
  
end
