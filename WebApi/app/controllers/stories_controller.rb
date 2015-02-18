class StoriesController < ApplicationController
  before_action :require_api_key
  
  def index
    # TODO_ implement limit and amount
    stories = StoryCollection.new(Story.all.order(updated_at: :desc))
    
    respond = {
      number_of_stories: stories.get_length,
      urls: {
        # TODO: add links to creators
        # TODO: add links to tags
        self: Rails.configuration.baseurl + stories_path
      },
      stories: stories.get_presentation
    }
    
    render json: respond
  end
  
  def show
    story = Story.find(params['id'])
    respond = {
      urls: {
        self: story.self_url,
        all_stories: Rails.configuration.baseurl + stories_path
        # TODO: add links to creators and tags
      },
      story: story.get_presentation
    }
    
    render json: respond
  end
  
end
