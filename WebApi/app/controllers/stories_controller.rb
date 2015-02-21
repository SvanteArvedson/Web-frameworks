class StoriesController < ApplicationController
  before_action :require_api_key
  
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
  
  def search
    if params['query'].nil?
      message = ErrorMessage.new("You must send a query to do a search", "You must send a query to do a search")
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
  
end
