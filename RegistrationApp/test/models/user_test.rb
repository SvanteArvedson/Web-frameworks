require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Not valid without email" do
    u = User.new
    
    assert_not u.valid?
  end
  
  test "Not valid with unvalid email" do
    u = User.new(email: "unvalid.email.example.com")
    
    assert_not u.valid?
  end
  
  test "Valid with valid email" do
    u = User.new(email: "valid.email@example.com")
    
    assert u.valid?
  end
  
  test "Should not save already existing email" do
    u1 = User.new(email: "valid.email@example.com")
    u2 = User.new(email: "valid.email@example.com")
    
    assert u1.save
    assert_not u2.save
  end

end
