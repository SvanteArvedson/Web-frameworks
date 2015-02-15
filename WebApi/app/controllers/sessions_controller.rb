class SessionsController < ApplicationController
  
  def authenticate
    creator = Creator.find_by_email(params[:email])
    
    if creator && creator.authenticate(params[:password])
      # auth_token valid one hour 
      auth_token = AuthToken.new(creator.id, Time.now + 1.hours)
      render json: { auth_token: encodeJWT(auth_token), terminates_at: (Time.now.utc + 1.hours) }
    else
      message = ErrorMessage.new("Invalid email or password", "Invalid email or password")
      render json: message, status: :unauthorized
    end
    
  end
  
end
