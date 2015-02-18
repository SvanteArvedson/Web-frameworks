class TagsController < ApplicationController
  before_action :require_api_key
  
  def index
    # TODO_ implement limit and offset
    tag_collection = TagCollection.new(Tag.all.order(:name))
    respond = {
      number_of_tags: tag_collection.length,
      urls: {
        self: Rails.configuration.baseurl + tags_path,
        # TODO: add links to creators
        all_stories: Rails.configuration.baseurl + stories_path
      },
      tags: tag_collection.presentation
    }
    
    render json: respond
    
  end
  
  def show
    tag = Tag.find(params['id'])
    respond = {
      urls: {
        self: tag.self_url,
        # TODO: add links to creators
        all_stories: Rails.configuration.baseurl + stories_path,
        all_tags: Rails.configuration.baseurl + tags_path
      },
      tag: tag.presentation
    }
    
    render json: respond
  end

end
