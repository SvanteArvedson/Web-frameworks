class StoriesController < ApplicationController
  before_action :require_api_key
  before_action :require_auth_token, only: [ :add_tags, :create, :destroy, :update ]
  
  # add tags to a story object
  def add_tags
    # if parameter tag-ids isn't present
    if params['tag-ids'].nil?
      render json: ErrorMessage.new(
        'You must send an array with tag ids as an json string in parameter "tags".', 
        'Unvalid request. Contact the system owner.',
        {}
        ), status: :bad_request
      return  
      # if cretor trying to modify another creators story
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
  
  # creates a new story object
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
  
  # deletes a story from the database
  def destroy
    # if a creator is trying to delete another ctearors story
    if auth_token['creator_id'] != Story.find(params[:id]).creator.id.to_i
      render json: ErrorMessage.new(
        "You must be logged as the creator of the story to delete it.", 
        "Forbidden!",
        {}
      ), status: :forbidden
      return
    else
      story = Story.find(params[:id])
      story.destroy
      
      render json: {
        message: "Story have been deleted."
      }
    end
  end
  
  # returns a collection of story objects
  def index
    # can handle limit and offset parameters
    if params[:limit].present? && params[:offset].present?
      if params['tag_id'].present?
        tag = Tag.find(params['tag_id'])
        stories = tag.stories.order(updated_at: :desc).offset(params[:offset]).limit(params[:limit])
        story_collection = StoryCollection.new(stories)
      elsif params['creator_id'].present?
        creator = Creator.find(params['creator_id'])
        stories = creator.stories.order(updated_at: :desc).offset(params[:offset]).limit(params[:limit])
        story_collection = StoryCollection.new(stories)
      else
        story_collection = StoryCollection.new(Story.all.order(updated_at: :desc).offset(params[:offset]).limit(params[:limit]))
      end
    else
      if params['tag_id'].present?
        story_collection = StoryCollection.new(Tag.find(params['tag_id']).stories.order(updated_at: :desc))
      elsif params['creator_id'].present?
        story_collection = StoryCollection.new(Creator.find(params['creator_id']).stories.order(updated_at: :desc))
      else
        story_collection = StoryCollection.new(Story.all.order(updated_at: :desc))
      end
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
  
  # returns a collection of story objects near the position in parameters
  def nearby
    # if parameters is missing
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
  
  # returns a collection of stories matching a query (words, tag or/and creator)
  def search
    if params['query'].nil? && params['tag'].nil? && params['creator'].nil?
      message = ErrorMessage.new(
        "You must send a query, tag or creator to do a search", 
        "You must send a query, tag or creator to do a search",
        {}
      )
      render json: message, status: :bad_request
    else
      stories = []
      fetched = false
      if params['tag'].present?
        stories = Tag.find(params['tag']).stories
        fetched = true
      end
      if params['creator'].present?
        if fetched
          stories = stories.select { |x| x.creator_id.to_s == params['creator'] }
        else
          stories = Creator.find(params['creator']).stories
          fetched = true
        end
      end
      if params['query'].present?
        if fetched
          stories = stories.select { |x| x.name.include? params['query'] or x.description.include? params['query'] }
        else
          stories = Story.where("name LIKE ? OR description LIKE ?", "%" + params['query'] + "%", "%" + params['query'] + "%")
          fetched = true
        end
      end
      
      # return result
      story_collection = StoryCollection.new(stories)
      respond = {
        query: params['query'],
        creator: params['creator'],
        tag: params['tag'],
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
  
  # returns a single story object
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
  
  # updates a story object
  def update
    # if a creator is trying to update another creators story
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