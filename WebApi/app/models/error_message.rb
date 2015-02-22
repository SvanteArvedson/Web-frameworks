class ErrorMessage
  attr_accessor :developer_message
  attr_accessor :user_message
  attr_accessor :errors
  
  def initialize(developer_message, user_message, errors)
    @developer_message = developer_message
    @user_message = user_message
    @errors = errors
  end

  def presentation
    return {
      developer_message: @developer_message,
      user_message: @user_message,
      errors: errors_presentation
    }
  end
  
  private
  
  # presents model errors
  def errors_presentation
    pres = {}
    
    @errors.each do |attribute, message|
      pres[attribute] = message
    end
    
    return pres
  end
end