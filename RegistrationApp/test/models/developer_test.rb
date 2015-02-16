require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  test "Not valid without email" do
    d = Developer.new
    
    assert_not d.valid?
  end
  
  test "Not valid with unvalid email" do
    d = Developer.new(email: "unvalid.email.example.com")
    
    assert_not d.valid?
  end
  
  test "Valid with valid email" do
    d = Developer.new( name: "Cool", email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt", admin: false)
    
    assert d.valid?
  end
  
  test "Should not save already existing email" do
    d1 = Developer.new(name: "Valid Name", email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    d2 = Developer.new(name: "Valid Name", email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    
    assert d1.save
    assert_not d2.save
  end

  test "Not valid with too short password" do
    d = Developer.new(name: "Valid Name", email: "valid.email@example.com", password: "hem", password_confirmation: "hem")
    
    assert_not d.valid?
  end
  
end