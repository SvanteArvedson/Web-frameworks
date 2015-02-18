class Story < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  # relations
  belongs_to :creator
  belongs_to :position
  has_and_belongs_to_many :tags
  
  # validation
  validates :creator, presence: true
  validates :position, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  
  # creates a json presentation of the story
  def presentation
    return {
      url: self_url,
      id: id,
      name: name,
      description: description,
      created_at: created_at,
      updated_at: updated_at,
      position: {
        latitude: position.latitude.to_s,
        longitude: position.longitude.to_s,
      },
      creator: Rails.configuration.baseurl + creator_path(creator),
      tags: Rails.configuration.baseurl + story_tags_path(self)
    }
  end
  
  def self_url
    Rails.configuration.baseurl + story_path(self)
  end
end
