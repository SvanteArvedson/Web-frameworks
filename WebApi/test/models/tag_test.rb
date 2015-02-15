require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "Not valid without name" do
    t = Tag.new
    
    assert_not t.valid?
  end
  
  test "Not valid with too long name" do
    t = Tag.new(name: "TooLongNameTooLongNameTooLongNameTooLongName")
    
    assert_not t.valid?
  end
  
  test "Valid with valid name" do
    t = Tag.new(name: "ValidName")
    
    assert t.valid?
  end
end
