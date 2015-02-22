require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "GET /tags with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/tags' }, { controller: "tags", action: "index" }) 
    get :index, { 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /tags should return status 200" do
    assert_routing({ method: 'get', path: '/tags' }, { controller: "tags", action: "index" }) 
    get :index, { 'api-key' => Application.first.api_key }
    assert_response :success
  end
  
  test "GET /tags/1 with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/tags/1' }, { controller: "tags", action: "show", id: "1" }) 
    get :show, { id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /tags/1 should return status 200" do
    assert_routing({ method: 'get', path: '/tags/1' }, { controller: "tags", action: "show", id: "1" }) 
    get :show, { id: "1", 'api-key' => Application.first.api_key }
    assert_response :success
  end
  
  test "GET /tags/1/stories with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/tags/1/stories' }, { controller: "stories", action: "index", tag_id: "1" }) 
    
    @controller = StoriesController.new
    get :index, { tag_id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /tags/1/stories should return status 200" do
    assert_routing({ method: 'get', path: '/tags/1/stories' }, { controller: "stories", action: "index", tag_id: "1" }) 
    
    @controller = StoriesController.new
    get :index, { tag_id: "1", 'api-key' => Application.first.api_key }
    assert_response :success
  end
  
  test "POST /tags without auth-token should return status 400" do
    assert_routing({ method: 'post', path: '/tags' }, { controller: "tags", action: "create" }) 
    post :create, { 'api-key' => Application.first.api_key, name: "romantiskt" }
    assert_response :bad_request
  end
  
  test "POST /tags with valid api-key and auth-token and valid data should return status 201" do
    @controller = SessionsController.new()
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    @controller = TagsController.new()
    assert_routing({ method: 'post', path: '/tags' }, { controller: "tags", action: "create" }) 
    post :create, { 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'], name: "romantiskt" }
    assert_response :created
  end
end
