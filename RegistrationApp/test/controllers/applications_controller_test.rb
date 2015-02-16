require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  
  test "GET /developers/2/applications/new renders a new application form" do
    assert_routing '/developers/2/applications/new', { controller: "applications", action: "new", developer_id: "2" }
    
    @controller = SessionsController.new
    post :create, { session: { email: "developer.one@example.com", password: "hemligt" } }
    
    @controller = ApplicationsController.new
    get :new, { developer_id: "2" }
    assert_response :success
  end
  
  test "POST /developers/1/applications should go to contoller applications#create" do
    assert_routing({ method: 'post', path: '/developers/1/applications' }, { controller: "applications", action: "create", developer_id: "1" })
    post :create, { developer_id: "1", application: { name: "BeautifulApplication",  application_type_id: "1" }}
    assert_response :redirect
  end
  
  test "POST /developers/2/applications with wrong credentials should go back to contoller applications#new" do
    assert_routing({ method: 'post', path: '/developers/2/applications' }, { controller: "applications", action: "create", developer_id: "2" })
    
    @controller = SessionsController.new
    post :create, { session: { email: "developer.one@example.com", password: "hemligt" } }
    
    @controller = ApplicationsController.new
    post :create, { developer_id: "2", application: { name: nil, application_type_id: "2" }}
    assert_response :success
  end
  
  test "DELETE /developers/:developer_id/applications/:id should destroy application with id 1 on developers with developer_id 1" do
    assert_routing({ method: 'delete', path: '/developers/1/applications/1' }, { controller: "applications", action: "destroy", developer_id: "1", id: "1" })
    delete :destroy, { developer_id: "1", id: "1" }
    assert_response :redirect
  end

end