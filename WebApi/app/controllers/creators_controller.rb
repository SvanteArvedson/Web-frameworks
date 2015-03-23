class CreatorsController < ApplicationController
  before_action :require_api_key
  before_action :require_auth_token, only: [ :destroy ]

  # creats a new creator object
  def create
    c = Creator.new(
      email: params['email'], 
      password: params['password'], 
      password_confirmation: params['password_confirmation']
    );
    
    if c.save
      render json: { 
        message: "New creator created", 
        url: Rails.configuration.baseurl + creator_path(c), 
        created_at: c.created_at 
      }, status: :created
    else
      respond = ErrorMessage.new(
        "Unvalid data. Failed to create new creator.", 
        "Failed to create new creator.",
        c.errors
      )
      render json: respond.presentation, status: :bad_request
    end
  end
  
  # deletes a creator object
  def destroy    
    # if authenticated creator isn't the same as the trying to be deleted 
    if auth_token['creator_id'] != params['id'].to_i
      render json: ErrorMessage.new(
        "You must be logged as the creator to delete it.", 
        "Forbidden!",
        {}
      ), status: :forbidden
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

  # returns a collection of creators
  def index
    # can take limit and offset parameters
    if params[:limit].present? && params[:offset].present? && params['story_id'].nil?
      creator_collection = CreatorCollection.new(Creator.all.order(:email).offset(params[:offset]).limit(params[:limit]))
    else
      if params['story_id'].present?
        creator_collection = CreatorCollection.new([Story.find(params['story_id']).creator])
      else
        creator_collection = CreatorCollection.new(Creator.all.order(:email))
      end
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
  
  # returns a single creator
  def show
    creator = Creator.find(params['id'])
    respond = {
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      creator: creator.presentation
    }
    
    render json: respond
  end
end