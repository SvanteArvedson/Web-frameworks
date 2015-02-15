require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  test "Not valid without longitude" do
    p = Position.new(latitude: 1111.111111)
    
    assert_not p.valid?
  end
  
  test "Not valid without latitude" do
    p = Position.new(longitude: 1111.111111)
    
    assert_not p.valid?
  end
  
  test "Valid with latitude and longitude" do
    p = Position.new(latitude: 1111.111111, longitude: 1111.111111)
    
    assert p.valid?
  end
end
