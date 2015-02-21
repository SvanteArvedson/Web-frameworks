require 'test_helper'

class CreatorsControllerTest < ActionController::TestCase
  
  test "GET /creators with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/creators' }, { controller: "creators", action: "index" }) 
    get :index, { 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /creators should return status 200" do
    assert_routing({ method: 'get', path: '/creators' }, { controller: "creators", action: "index" }) 
    get :index, { 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /creators/1 with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/creators/1' }, { controller: "creators", action: "show", id: "1" }) 
    get :show, { id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /creators/1 should return status 200" do
    assert_routing({ method: 'get', path: '/creators/1' }, { controller: "creators", action: "show", id: "1" }) 
    get :show, { id: "1", 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /creators/1/stories with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/creators/1/stories' }, { controller: "stories", action: "index", creator_id: "1" }) 
    
    @controller = StoriesController.new
    get :index, { creator_id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /creators/1/stories should return status 200" do
    assert_routing({ method: 'get', path: '/creators/1/stories' }, { controller: "stories", action: "index", creator_id: "1" }) 
    
    @controller = StoriesController.new
    get :index, { creator_id: "1", 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "POST /creators with valid api_key but with unvalid data should return status 400" do
    assert_routing({ method: 'post', path: '/creators' }, { controller: "creators", action: "create" }) 
    post :create, { 'api-key' => "Q1W2E3R4T5Y1", email: "creator.new@example.com", password: "hemligt", password_confirmation: "heligt" }
    assert_response :bad_request
  end
  
  test "POST /creators with valid api_key and valid data should return status 201" do
    assert_routing({ method: 'post', path: '/creators' }, { controller: "creators", action: "create" }) 
    post :create, { 'api-key' => Application.first.api_key, email: "creator.new@example.com", password: "hemligt", password_confirmation: "hemligt" }
    assert_response :created
  end
  
  test "DELETE /creators with valid api_key but unvalid auth-token should return status 403" do
    @controller = SessionsController.new()
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    
    @controller = CreatorsController.new()
    assert_routing({ method: 'delete', path: '/creators/1' }, { controller: "creators", action: "destroy", id: "1" }) 
    delete :destroy, { id: "1", 'api-key' => Application.first.api_key }
    assert_response :bad_request
  end
  
  test "DELETE /creators with valid api_key but logged in as someone else should return status 403" do
    @controller = SessionsController.new()
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.two@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    
    @controller = CreatorsController.new()
    assert_routing({ method: 'delete', path: '/creators/1' }, { controller: "creators", action: "destroy", id: "1" }) 
    delete :destroy, { id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'] }
    assert_response :forbidden
  end
  
  test "DELETE /creators with valid api_key and valid auth-token should return status 200" do
    @controller = SessionsController.new()
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    
    @controller = CreatorsController.new()
    assert_routing({ method: 'delete', path: '/creators/1' }, { controller: "creators", action: "destroy", id: "1" }) 
    delete :destroy, { id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'] }
    assert_response :success
  end
  
end
