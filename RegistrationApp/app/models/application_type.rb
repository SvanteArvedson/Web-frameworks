class ApplicationType < ActiveRecord::Base
  # Relations
  has_many :applications
  
  # Validation
  validates :name, presence: true, length: { maximum: 20 }
end
