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
    u = User.new( name: "Cool", email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt", admin: false)
    
    assert u.valid?
  end
  
  test "Should not save already existing email" do
    u1 = User.new(name: "Valid Name", email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    u2 = User.new(name: "Valid Name", email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    
    assert u1.save
    assert_not u2.save
  end

  test "Not valid with too short password" do
    u = User.new(name: "Valid Name", email: "valid.email@example.com", password: "hem", password_confirmation: "hem")
    
    assert_not u.valid?
  end
  
end
