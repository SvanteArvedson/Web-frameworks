class Tag < ActiveRecord::Base
  # relations
  has_and_belongs_to_many :stories
end
