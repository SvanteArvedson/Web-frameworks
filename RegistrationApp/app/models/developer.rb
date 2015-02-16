class Developer < ActiveRecord::Base
  has_secure_password
  
  # Relations
  has_many :applications, dependent: :destroy
  
  # Validation
  validates :email, presence: true, 
    uniqueness: { case_sensitive: false, message: "Email already registered" }, 
    email_format: { message: "Unvalid email" }
  validates :password, length: { minimum: 6 }
  
  # Makes sure email is in downcase and striped
  after_initialize do |developer|
    unless developer.email.nil?
      developer.email.strip!
      developer.email.downcase!
    end
  end
end
