require 'test_helper'

class DevelopersControllerTest < ActionController::TestCase
  
  test "GET /developers should list all developers" do
    assert_routing '/developers', { controller: "developers", action: "index" }
    
    @controller = SessionsController.new
    post :create, { session: { email: "Admin", password: "adminhemligt" } }
 
    @controller = DevelopersController.new
    get :index
    assert_response :success
  end
  
  test "GET /developers/2 should show developer with id 1" do
    assert_routing '/developers/2', { controller: "developers", action: "show", id: "2" }
    
    @controller = SessionsController.new
    post :create, { session: { email: "developer.one@example.com", password: "hemligt" } }
    
    @controller = DevelopersController.new 
    get :show, { id: "2" }
    assert_response :success
  end
  
  test "GET /developers/new should render a form to create a new developer" do
    assert_routing '/developers/new', { controller: "developers", action: "new" }
    get :new
    assert_response :success
  end
  
  test "POST /developers should go to contoller developers#create" do
    assert_routing({ method: 'post', path: '/developers' }, { controller: "developers", action: "create" })
    post :create, { developer: { name: "NewDeveloper", email: "email@example.com", password: "hemligt", password_confirmation: "hemligt" } }
    assert_response :redirect
  end
  
  test "POST /developers with wrong credentials should go back to developers#new" do
    assert_routing({ method: 'post', path: '/developers' }, { controller: "developers", action: "create" })
    post :create, { developer: { name: "NewDeveloper", email: "email@example.com", password: "hemligt", password_confirmation: "annorlunda" } }
    assert_response :success
  end
  
  test "DELETE /developers/:id should destroy developer with id 1" do
    assert_routing({ method: 'delete', path: '/developers/1' }, { controller: "developers", action: "destroy", id: "1" })
    delete :destroy, { id: "1" }
    assert_response :redirect
  end
  
end
