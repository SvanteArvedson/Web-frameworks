class Creator < ActiveRecord::Base
  has_secure_password
  
  # relations
  has_many :stories
  
  # validation
  validates :email, presence: true, 
    uniqueness: { case_sensitive: false, message: "Email already registered" }, 
    email_format: { message: "Unvalid email" }
  validates :password, presence: true, length: { minimum: 6 }
  
  # Makes sure email is in downcase and striped
  after_initialize do |user|
    unless user.email.nil?
      user.email.strip!
      user.email.downcase!
    end
  end
end
