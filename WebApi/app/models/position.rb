class Position < ActiveRecord::Base
  # relations
  has_many :stories
  
end
