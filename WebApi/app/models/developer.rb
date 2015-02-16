class Developer < ActiveRecord::Base
  has_secure_password
  
  # Relations
  has_many :applications, dependent: :destroy
  
  def readonly?
    return true
  end
 
  def before_destroy
    raise ActiveRecord::ReadOnlyRecord
  end
  
  def delete
    raise ActiveRecord::ReadOnlyRecord
  end
  
end