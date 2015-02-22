class TagsController < ApplicationController
  before_action :require_api_key
  before_action :require_auth_token, only: [ :create ]
  
  # creates a new tag
  def create
    t = Tag.new(
      name: params[:name]
    )
    
    if t.save
      render json: { 
        message: "New tag created", 
        url: Rails.configuration.baseurl + tag_path(t), 
        created_at: t.created_at 
      }, status: :created
    else
      respond = ErrorMessage.new(
        "Unvalid data. Failed to create new tag.", 
        "Failed to create new tag.",
        t.errors
      )
      render json: respond.presentation, status: :bad_request
    end
  end
  
  # returns a collection of tag objects
  def index
    # handles limit and offset parameters
    if params[:limit].present? && params[:offset].present?
      if params['story_id'].present?
        stories = Story.find(params['story_id'])
        tag_collection = TagCollection.new(stories.tags.order(:name).offset(params[:offset]).limit(params[:limit]))
      else
        tags = Tag.all.order(:name).offset(params[:offset]).limit(params[:limit])
        tag_collection = TagCollection.new(tags)
      end
    else
      if params['story_id'].present?
        tag_collection = TagCollection.new(Story.find(params['story_id']).tags.order(:name))
      else
        tag_collection = TagCollection.new(Tag.all.order(:name))
      end
    end
    
    respond = {
      number_of_tags: tag_collection.length,
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      tags: tag_collection.presentation
    }
    render json: respond
  end
  
  # return a single tag object
  def show
    tag = Tag.find(params['id'])
    respond = {
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      tag: tag.presentation
    }
    render json: respond
  end
end