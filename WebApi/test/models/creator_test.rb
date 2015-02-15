require 'test_helper'

class CreatorTest < ActiveSupport::TestCase
  test "Not valid without email" do
    c = Creator.new
    
    assert_not c.valid?
  end
  
  test "Not valid with unvalid email" do
    c = Creator.new(email: "unvalid.email.example.com")
    
    assert_not c.valid?
  end
  
  test "Valid with valid email" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    
    assert c.valid?
  end
  
  test "Should not save already existing email" do
    c1 = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    c2 = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    
    assert c1.save
    assert_not c2.save
  end

  test "Not valid with too short password" do
    c = Creator.new(email: "valid.email@example.com", password: "hem", password_confirmation: "hem")
    
    assert_not c.valid?
  end
end
