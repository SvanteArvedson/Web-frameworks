class Creator < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  has_secure_password
  
  # relations
  has_many :stories
  
  # validation
  validates :email, presence: true, 
    uniqueness: { case_sensitive: false, message: "Email already registered" }, 
    email_format: { message: "Unvalid email" }
  validates :password, presence: true, length: { minimum: 6 }
  
  # Makes sure email is in downcase and striped
  after_initialize do |creator|
    unless creator.email.nil?
      creator.email.strip!
      creator.email.downcase!
    end
  end
  
  # creates a json presentation of the creator
  def presentation
    return {
      url: self_url,
      id: id,
      email: email,
      created_at: created_at,
      updated_at: updated_at,
      stories: Rails.configuration.baseurl + creator_stories_path(self),
    }
  end
  
  def self_url
    Rails.configuration.baseurl + creator_path(self)
  end
end
