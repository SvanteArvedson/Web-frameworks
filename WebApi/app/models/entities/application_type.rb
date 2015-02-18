class ApplicationType < ActiveRecord::Base
  # Relations
  has_many :applications

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