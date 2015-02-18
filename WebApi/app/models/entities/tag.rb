class Tag < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  # relations
  has_and_belongs_to_many :stories
  
  # validation
  validates :name, presence: true, length: { maximum: 40 }
  
   # creates a json presentation of the tag
  def presentation
    return {
      url: self_url,
      id: id,
      name: name,
      created_at: created_at,
      updated_at: updated_at,
      # TODO: add proper url
      stories: "url_to_stories_with_this_tag"
    }
  end
  
  def number_of_stories
    stories.length
  end
  
  def self_url
    Rails.configuration.baseurl + tag_path(self)
  end
end
