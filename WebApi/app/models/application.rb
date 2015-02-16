class Application < ActiveRecord::Base
  # Relations
  belongs_to :developer
  belongs_to :application_type
  
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