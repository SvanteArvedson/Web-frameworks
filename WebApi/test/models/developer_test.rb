require 'test_helper'

class DeveloperTest < ActionController::TestCase
  
  test "should not save new developer" do
    d = Developer.new(name: "Name", email: "email@example.com", password: "hemligt", password_confirmation: "hemligt")
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { d.save }
  end
  
  test "should not update developer" do
    d = Developer.first
    d.name = "New Name"
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { d.save }
  end
  
  test "should not delete developer" do
    d = Developer.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { d.delete }
  end
  
  test "should not destroy developer" do
    d = Developer.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { d.destroy }
  end
  
  test "should fetch developer" do
    assert Developer.first
  end
  
end