class Creator < ActiveRecord::Base
  has_secure_password
  
  # relations
  has_many :stories
  
end
