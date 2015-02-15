require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  test "Not valid without name" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    p = Position.new(latitude: 1111.111111, longitude: 1111.111111)
    s = Story.new(description: "buu buu huu huu", creator: c, position: p)
    
    assert_not s.valid?
  end
  
  test "Not valid without description" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    p = Position.new(latitude: 1111.111111, longitude: 1111.111111)
    s = Story.new(name: "Monsterståry", creator: c, position: p)
    
    assert_not s.valid?
  end
  
  test "Not valid without creator" do
    p = Position.new(latitude: 1111.111111, longitude: 1111.111111)
    s = Story.new(name: "Monsterståry", description: "buu buu huu huu", position: p)
    
    assert_not s.valid?
  end
  
  test "Not valid without position" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    s = Story.new(name: "Monsterståry", description: "buu buu huu huu", creator: c)
    
    assert_not s.valid?
  end
  
  test "Not valid with too long name" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    p = Position.new(latitude: 1111.111111, longitude: 1111.111111)
    s = Story.new(name: "MonsterståryMonsterståryMonsterståryMonsterståryMonsterståry", description: "buu buu huu huu", creator: c, position: p)
    
    assert_not s.valid?
  end
  
  test "Valid with name, description, creator and position" do
    c = Creator.new(email: "valid.email@example.com", password: "hemligt", password_confirmation: "hemligt")
    p = Position.new(latitude: 1111.111111, longitude: 1111.111111)
    s = Story.new(name: "Monsterståry", description: "buu buu huu huu", creator: c, position: p)
    
    assert s.valid?
  end
 
end
