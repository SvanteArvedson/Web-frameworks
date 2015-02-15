class Position < ActiveRecord::Base
  # relations
  has_many :stories
  
  # validation
  validates :latitude, presence: true
  validates :longitude, presence: true
end
