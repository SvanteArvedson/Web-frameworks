class ErrorMessage
  attr_accessor :developer_message
  attr_accessor :user_message
  
  def initialize(developer_message, user_message)
    @developer_message = developer_message
    @user_message = user_message
  end
end