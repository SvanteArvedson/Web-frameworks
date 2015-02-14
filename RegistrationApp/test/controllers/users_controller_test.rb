require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "GET /users should list all users" do
    assert_routing '/users', { controller: "users", action: "index" }
    
    @controller = SessionsController.new
    post :create, { session: { email: "Admin", password: "adminhemligt" } }
 
    @controller = UsersController.new
    get :index
    assert_response :success
  end
  
  test "GET /users/2 should show user with id 1" do
    assert_routing '/users/2', { controller: "users", action: "show", id: "2" }
    
    @controller = SessionsController.new
    post :create, { session: { email: "user.one@example.com", password: "hemligt" } }
    
    @controller = UsersController.new 
    get :show, { id: "2" }
    assert_response :success
  end
  
  test "GET /users/new should render a form to create a new user" do
    assert_routing '/users/new', { controller: "users", action: "new" }
    get :new
    assert_response :success
  end
  
  test "POST /users should go to contoller users#create" do
    assert_routing({ method: 'post', path: '/users' }, { controller: "users", action: "create" })
    post :create, { user: { name: "NewUser", email: "email@example.com", password: "hemligt", password_confirmation: "hemligt" } }
    assert_response :redirect
  end
  
  test "POST /users with wrong credentials should go back to users#new" do
    assert_routing({ method: 'post', path: '/users' }, { controller: "users", action: "create" })
    post :create, { user: { name: "NewUser", email: "email@example.com", password: "hemligt", password_confirmation: "annorlunda" } }
    assert_response :success
  end
  
  test "DELETE /users/:id should destroy user with id 1" do
    assert_routing({ method: 'delete', path: '/users/1' }, { controller: "users", action: "destroy", id: "1" })
    delete :destroy, { id: "1" }
    assert_response :redirect
  end
  
end
