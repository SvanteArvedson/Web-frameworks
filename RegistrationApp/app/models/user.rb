class User < ActiveRecord::Base
  # Relations
  has_many :applications
  
  # Validation
  validates :email, presence: true, 
    uniqueness: { case_sensitive: false, message: "Email already registered" }, 
    email_format: { message: "Unvalid email" }
end
