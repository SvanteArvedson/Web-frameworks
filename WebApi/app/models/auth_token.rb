class AuthToken
  attr_accessor :creator_id
  attr_accessor :terminates_at
  
  def initialize (creator_id, terminates_at)
    @creator_id = creator_id
    @terminates_at = terminates_at
  end
end