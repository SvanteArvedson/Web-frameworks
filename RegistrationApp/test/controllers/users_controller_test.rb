require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "GET /users should list all users" do
    assert_routing '/users', { controller: "users", action: "index" }
    get :index
    assert_response :success
  end
  
  test "GET /users/:id should show one user" do
    assert_routing '/users/1', { controller: "users", action: "show", id: "1" }
    get :show, { id: "1" }
    assert_response :success
  end
  
  test "GET /users/new should render a form to create a new user" do
    assert_routing '/users/new', { controller: "users", action: "new" }
    get :new
    assert_response :success
  end
  
  test "POST /users should go to contoller users#create" do
    assert_routing({ method: 'post', path: '/users' }, { controller: "users", action: "create" })
    post :create
  end
  
end
