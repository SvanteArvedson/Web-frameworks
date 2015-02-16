require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "Not valid without a name" do
    a = Application.new
    
    assert_not a.valid?
  end
  
  test "Not valid with too long name" do
    a = Application.new(name: "ThisIsAVeryLongNameIndeedThisIsAVeryLongNameIndeedThisIsAVeryLongNameIndeedThisIsAVeryLongNameIndeedThis")
    
    assert_not a.valid?
  end
  
  test "Not valid with same api key twice" do
    key = SecureRandom.hex
    d = Developer.find(2)
    t = ApplicationType.first
    
    a1 = Application.new(name: "AGoodName", developer: d, application_type: t)
    a2 = Application.new(name: "AnOtherGoodName", developer: d, application_type: t)
    
    a1.api_key = key
    a2.api_key = key
    
    assert a1.save
    assert_not a2.save
  end
  
  test "Not valid with empty api_key" do
    a = Application.new(name: "AGoodName")
    a.api_key = nil
    
    assert_not a.valid?
  end
  
  test "Valid with a name with less than 100 characters" do
    d = Developer.find(2)
    t = ApplicationType.first
    a = Application.new(name: "AGoodName", developer: d, application_type: t)
    
    assert a.valid?
  end
end