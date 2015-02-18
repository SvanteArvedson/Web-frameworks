class CreatorsController < ApplicationController
  before_action :require_api_key
  # before_action :require_auth_token, only: [ :create ]

  def create
    c = Creator.new(
      email: params['email'], 
      password: params['password'], 
      password_confirmation: params['password_confirmation']
    );
    
    if c.save
      # TODO: create proper url
      render json: { 
        message: "New creator created", 
        url: Rails.configuration.baseurl + creator_path(c), 
        created_at: c.created_at 
      }, status: :created
    else
      # TODO: Add proper error messages
      render json: ErrorMessage.new(
        "Unvalid email, password or password_confirmation.", 
        "Faild to create new creator."
      ), status: :bad_request
    end
  end

  def index
    # TODO_ implement limit and offset
    creator_collection = CreatorCollection.new(Creator.all.order(:email))
    respond = {
      number_of_creators: creator_collection.length,
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      creators: creator_collection.presentation
    }
    
    render json: respond
  end
  
  def show
    creator = Creator.find(params['id'])
    respond = {
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      story: creator.presentation
    }
    
    render json: respond
  end
  
end