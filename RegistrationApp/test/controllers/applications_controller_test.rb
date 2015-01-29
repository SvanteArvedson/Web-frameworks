require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  
  test "GET /users/1/applications/new renders a new application form" do
    assert_routing '/users/1/applications/new', { controller: "applications", action: "new", user_id: "1" }
    get :new, { user_id: "1" }
    assert_response :success
  end

end