class Application < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :application_type
  
  # Validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :api_key, presence: true, uniqueness: { case_sensitive: true, message: "Api key already exists" }
  validates :application_type, presence: true
  
  # Creates api_key if nil or empty
  after_initialize do |app|
    if app.api_key.nil? || app.api_key.empty?
      app.api_key = SecureRandom.hex
    end
  end
end