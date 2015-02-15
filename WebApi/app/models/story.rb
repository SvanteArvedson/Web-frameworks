class Story < ActiveRecord::Base
  # relations
  belongs_to :creator
  belongs_to :position
  has_and_belongs_to_many :tags
  
  # validation
  validates :creator, presence: true
  validates :position, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
end
