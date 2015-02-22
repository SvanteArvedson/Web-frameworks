class StoriesController < ApplicationController
  before_action :require_api_key
  before_action :require_auth_token, only: [ :add_tags, :create, :update ]
  
  def add_tags
    if params['tag-ids'].nil?
      render json: ErrorMessage.new(
        'You must send an array with tag ids as an json string in parameter "tags".', 
        'Unvalid request. Contact the system owner.',
        {}
        ), status: :bad_request
      return  
    elsif auth_token['creator_id'] != Story.find(params[:story_id]).creator.id.to_i
      render json: ErrorMessage.new(
        "You must be logged as the creator of the story to modify it.", 
        "Forbidden!",
        {}
      ), status: :forbidden
      return
    else
      s = Story.find(params[:story_id])
      tag_ids = JSON.parse(params['tag-ids'])
      
      s.tags = []
      tag_ids.each do |tag_id|
        t = Tag.find_by_id(tag_id)
        unless t.nil?
          s.tags << t
        end
      end
      
      render json: { 
        message: "Story updated", 
        url: Rails.configuration.baseurl + story_path(s), 
        created_at: s.updated_at 
        }, status: :success      
    end
  end
  
  def create
    s = Story.new(
      name: params[:name],
      description: params[:description],
      latitude: params[:latitude],
      longitude: params[:longitude],
      creator: Creator.find(auth_token['creator_id'].to_i)
    )

    if s.save
      render json: { 
        message: "New story created", 
        url: Rails.configuration.baseurl + story_path(s), 
        created_at: s.created_at 
        }, status: :created
    else
      respond = ErrorMessage.new(
        "Unvalid data. Failed to create new story.", 
        "Failed to create new story.",
        s.errors
      )
      render json: respond.presentation, status: :bad_request
    end
  end
  
  def index
    # TODO: implement limit and offset
    if params['tag_id'].present?
      story_collection = StoryCollection.new(Tag.find(params['tag_id']).stories.order(updated_at: :desc))
    elsif params['creator_id'].present?
      story_collection = StoryCollection.new(Creator.find(params['creator_id']).stories.order(updated_at: :desc))
    else
      story_collection = StoryCollection.new(Story.all.order(updated_at: :desc))
    end
    
    respond = {
      number_of_stories: story_collection.length,
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      stories: story_collection.presentation
    }
    
    render json: respond
  end
  
  def nearby
    if params['latitude'].nil? || params['longitude'].nil?
      message = ErrorMessage.new(
        "You must send latitude and longitude to get nearby stories", 
        "You must send latitude and longitude to get nearby stories",
        {}
      )
      render json: message, status: :bad_request
    else
      distance = params['distance'].present? ? params['distance'] : 20
      story_collection = StoryCollection.new(Story.near([params['latitude'], params['longitude']], distance, units: :km))
      
      respond = {
        latitude: params['latitude'],
        longitude: params['longitude'],
        number_of_stories: story_collection.length,
        urls: {
          self: request.url,
          all_creators: Rails.configuration.baseurl + creators_path,
          all_stories: Rails.configuration.baseurl + stories_path,
          all_tags: Rails.configuration.baseurl + tags_path
        },
        stories: story_collection.presentation
      }
      
      render json: respond
    end
  end
  
  def search
    if params['query'].nil?
      message = ErrorMessage.new(
        "You must send a query to do a search", 
        "You must send a query to do a search",
        {}
      )
      render json: message, status: :bad_request
    else
      querys = params['query'].split(/\W+/)
      stories = []
      
      querys.each do |query|
        stories += Story.where("name LIKE ? OR description LIKE ?", "%" + query + "%", "%" + query + "%")
      end
      
      story_collection = StoryCollection.new(stories)
      
      respond = {
        query: params['query'],
        number_of_stories: story_collection.length,
        urls: {
          self: request.url,
          all_creators: Rails.configuration.baseurl + creators_path,
          all_stories: Rails.configuration.baseurl + stories_path,
          all_tags: Rails.configuration.baseurl + tags_path
        },
        stories: story_collection.presentation
      }
      
      render json: respond
    end
    
  end
  
  def show
    story = Story.find(params['id'])
    respond = {
      urls: {
        self: request.url,
        all_creators: Rails.configuration.baseurl + creators_path,
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      story: story.presentation
    }
    
    render json: respond
  end
  
  def update
    if auth_token['creator_id'] != Story.find(params[:id]).creator.id.to_i
      render json: ErrorMessage.new(
        "You must be logged as the creator of the story to update it.", 
        "Forbidden!",
        {}
      ), status: :forbidden
      return
    elsif Story.update(
      params[:id], 
      name: params[:name],
      description: params[:description],
      latitude: params[:latitude],
      longitude: params[:longitude]
    )
      s = Story.find(params[:id])
      
      render json: { 
        message: "Story updated", 
        url: Rails.configuration.baseurl + story_path(s), 
        updated_at: s.updated_at 
        }, status: :success
    else
      respond = ErrorMessage.new(
        "Unvalid data. Failed to update story.", 
        "Failed to update story.",
        s.errors
      )
      render json: respond.presentation, status: :bad_request
    end
  end
end