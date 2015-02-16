require 'test_helper'

class ApplicationTest < ActionController::TestCase
  
  test "should not save new application" do
    d = Developer.first
    t = ApplicationType.first
    a = Application.new(name: "Example", developer: d, application_type: t)
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { a.save }
  end
  
  test "should not update application_type" do
    a = Application.first
    a.name = "Example"
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { a.save }
  end
  
  test "should not delete application_type" do
    a = Application.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { a.delete }
  end
  
  test "should not destroy application_type" do
    a = Application.first
    
    assert_raises(ActiveRecord::ReadOnlyRecord) { a.destroy }
  end
  
  test "should fetch application" do
    assert Application.first
  end
  
end