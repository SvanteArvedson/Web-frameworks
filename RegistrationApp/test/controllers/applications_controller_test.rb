require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  
  test "GET /users/1/applications/new renders a new application form" do
    assert_routing '/users/1/applications/new', { controller: "applications", action: "new", user_id: "1" }
    get :new, { user_id: "1" }
    assert_response :success
  end
  
  test "POST /users/1/applications should go to contoller applications#create" do
    assert_routing({ method: 'post', path: '/users/1/applications' }, { controller: "applications", action: "create", user_id: "1" })
    post :create, { user_id: "1", application: { name: "BeautifulApplication",  application_type_id: "1" }}
    assert_response :redirect
  end
  
  test "POST /users/1/applications with wrong credentials should go back to contoller applications#new" do
    assert_routing({ method: 'post', path: '/users/1/applications' }, { controller: "applications", action: "create", user_id: "1" })
    post :create, { user_id: "1", application: { application_type_id: "1" }}
    assert_response :success
  end
  
  test "DELETE /users/:user_id/applications/:id should destroy application with id 1 on user with user_id 1" do
    assert_routing({ method: 'delete', path: '/users/1/applications/1' }, { controller: "applications", action: "destroy", user_id: "1", id: "1" })
    delete :destroy, { user_id: "1", id: "1" }
    assert_response :redirect
  end

end