class Tag < ActiveRecord::Base
  # relations
  has_and_belongs_to_many :stories
  
  # validation
  validates :name, presence: true, length: { maximum: 40 }
end
