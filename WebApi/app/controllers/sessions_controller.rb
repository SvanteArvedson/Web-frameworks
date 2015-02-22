class SessionsController < ApplicationController
  before_action :require_api_key
  
  def authenticate
    creator = Creator.find_by_email(params[:email])
    
    if creator && creator.authenticate(params[:password])
      # auth_token valid one hour 
      auth_token = AuthToken.new(creator.id, Time.now + 1.hours)
      render json: { auth_token: encodeJWT(auth_token), terminates_at: (Time.now.utc + 1.hours).to_r }
    else
      message = ErrorMessage.new(
        "Unvalid email or password", 
        "Unvalid email or password",
        {}
      )
      render json: message, status: :unauthorized
    end
  end
end
