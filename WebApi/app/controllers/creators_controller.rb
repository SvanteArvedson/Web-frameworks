class CreatorsController < ApplicationController
  before_action :require_api_key
  before_action :require_auth_token

  def create
    c = Creator.new(email: params['email'], password: params['password'], password_confirmation: params['password_confirmation']);
    
    if c.save
      # TODO: create proper url
      render json: { message: "New creator created", url: "link_to_the_new_creator", created_at: c.created_at }, status: :created
    else
      # TODO: Add proper error messages
      render json: ErrorMessage.new("Unvalid email, password or password_confirmation.", "Faild to create new creator."), status: :bad_request
    end
  end

end