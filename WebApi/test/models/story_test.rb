require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  test "Not valid without name" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    s = Story.new(description: "buu buu huu huu", creator: c, latitude: 11.111111, longitude: 11.111111)
    
    assert_not s.valid?
  end
  
  test "Not valid without description" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    s = Story.new(name: "Monsterståry", creator: c, latitude: 11.111111, longitude: 11.111111)
    
    assert_not s.valid?
  end
  
  test "Not valid without creator" do
    s = Story.new(name: "Monsterståry", description: "buu buu huu huu", latitude: 11.111111, longitude: 11.111111)
    
    assert_not s.valid?
  end
  
  test "Not valid without latitude and longitude" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    s = Story.new(name: "Monsterståry", description: "buu buu huu huu", creator: c)
    
    assert_not s.valid?
  end
  
  test "Not valid with too long name" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    s = Story.new(name: "MonsterståryMonsterståryMonsterståryMonsterståryMonsterståry", description: "buu buu huu huu", creator: c, latitude: 11.111111, longitude: 11.111111)
    
    assert_not s.valid?
  end
  
  test "Valid with name, description, creator and position" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    s = Story.new(name: "Monsterståry", description: "buu buu huu huu", creator: c, latitude: 11.111111, longitude: 11.111111)
    
    assert s.valid?
  end
 
end
