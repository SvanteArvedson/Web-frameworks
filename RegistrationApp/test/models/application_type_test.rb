require 'test_helper'

class ApplicationTypeTest < ActiveSupport::TestCase
  test "Not valid without name" do
    a = ApplicationType.new
    
    assert_not a.valid?
  end
  
  test "Not valid with too long name" do
    a = ApplicationType.new(name: "ThisIsAVeryLongNameIndeed")
    
    assert_not a.valid?
  end
  
  test "Valid with name with less than 20 characters" do
    a = ApplicationType.new(name: "AGoodName")
    
    assert a.valid?
  end
end
