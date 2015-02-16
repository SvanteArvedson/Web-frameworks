require 'test_helper'

class UserTest < ActionController::TestCase
  
  test "should not save new user" do
    u = User.new(name: "Name", email: "email@example.com", password: "hemligt", password_confirmation: "hemligt")
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { u.save }
  end
  
  test "should not update user" do
    u = User.first
    u.name = "New Name"
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { u.save }
  end
  
  test "should not delete user" do
    u = User.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { u.delete }
  end
  
  test "should not destroy user" do
    u = User.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { u.destroy }
  end
  
  test "should fetch user" do
    assert User.first
  end
  
end