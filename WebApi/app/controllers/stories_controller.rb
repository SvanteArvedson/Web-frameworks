class StoriesController < ApplicationController
  before_action :require_api_key
  
  def index
    # TODO_ implement limit and offset
    if !params['tag_id'].nil?
      story_collection = StoryCollection.new(Tag.find(params['tag_id']).stories.order(updated_at: :desc))
    elsif !params['creator_id'].nil?
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
