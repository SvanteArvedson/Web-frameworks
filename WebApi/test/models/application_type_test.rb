require 'test_helper'

class ApplicationTypeTest < ActionController::TestCase
  
  test "should not save new application_type" do
    t = ApplicationType.new(name: "Example")
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { t.save }
  end
  
  test "should not update application_type" do
    t = ApplicationType.first
    t.name = "Example"
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { t.save }
  end
  
  test "should not delete application_type" do
    t = ApplicationType.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { t.delete }
  end
  
  test "should not destroy application_type" do
    t = ApplicationType.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { t.destroy }
  end
  
  test "should fetch application_type" do
    assert ApplicationType.first
  end
  
end