class StoriesController < ApplicationController
  before_action :require_api_key
  
  def index
    # TODO_ implement limit and offset
    story_collection = StoryCollection.new(Story.all.order(updated_at: :desc))
    respond = {
      number_of_stories: story_collection.length,
      urls: {
        self: Rails.configuration.baseurl + stories_path,
        all_creators: Rails.configuration.baseurl + creators_path,
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
        self: story.self_url,
        # TODO: add links to creators
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      story: story.presentation
    }
    
    render json: respond
  end
  
end
