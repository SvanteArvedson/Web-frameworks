class CreatorsController < ApplicationController
  before_action :require_api_key
  before_action :require_auth_token, only: [ :destroy ]

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
  
  def destroy    
    if auth_token['creator_id'] != params['id'].to_i
      render json: ErrorMessage.new("You must be logged as the creator to delete it.", "Forbidden!"), status: :forbidden
      return
    else
      creator = Creator.find(params[:id])
      creator.destroy
      
      respond = {
        message: "Creator have been deleted."
      }
      render json: respond
    end
    
  end

  def index
    # TODO_ implement limit and offset
    if params['story_id'].present?
      creator_collection = CreatorCollection.new([Story.find(params['story_id']).creator])
    else
      creator_collection = CreatorCollection.new(Creator.all.order(:email))
    end
    
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