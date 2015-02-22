require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  test "GET /stories with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/stories' }, { controller: "stories", action: "index" }) 
    get :index, { 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /stories should return status 200" do
    assert_routing({ method: 'get', path: '/stories' }, { controller: "stories", action: "index" }) 
    get :index, { 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /stories/1 with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/stories/1' }, { controller: "stories", action: "show", id: "1" }) 
    get :show, { id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /stories/1 should return status 200" do
    assert_routing({ method: 'get', path: '/stories/1' }, { controller: "stories", action: "show", id: "1" }) 
    get :show, { id: "1", 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /stories/1/creators with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/stories/1/creators' }, { controller: "creators", action: "index", story_id: "1" }) 
    
    @controller = CreatorsController.new
    get :index, { story_id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /stories/1/creators should return status 200" do
    assert_routing({ method: 'get', path: '/stories/1/creators' }, { controller: "creators", action: "index", story_id: "1" }) 
    
    @controller = CreatorsController.new
    get :index, { story_id: "1", 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /stories/1/tags with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/stories/1/tags' }, { controller: "tags", action: "index", story_id: "1" }) 
    
    @controller = TagsController.new
    get :index, { story_id: "1", 'api-key' => "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /stories/1/tags should return status 200" do
    assert_routing({ method: 'get', path: '/stories/1/tags' }, { controller: "tags", action: "index", story_id: "1" }) 
    
    @controller = TagsController.new
    get :index, { story_id: "1", 'api-key' => "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /stories/search?query=Blodkorv should return status 200" do
    assert_routing({ method: 'get', path: '/stories/search' }, { controller: "stories", action: "search" }) 
    
    get :search, { 'api-key' => "Q1W2E3R4T5Y1", query: "Blodkorv" }
    assert_response :success
  end
  
  test "GET /stories/search?query=Blodkorv with unvalid api-key should return status 400" do
    assert_routing({ method: 'get', path: '/stories/search' }, { controller: "stories", action: "search" }) 
    
    get :search, { 'api-key' => "Q1W2E3R4T5Y", query: "Blodkorv" }
    assert_response :bad_request
  end
  
  test "GET /stories/nearby?latitude=56.161931&longitude=13.7762741 should return status 200" do
    assert_routing({ method: 'get', path: '/stories/nearby' }, { controller: "stories", action: "nearby" }) 
    
    get :nearby, { 'api-key' => "Q1W2E3R4T5Y1", latitude: 56.161931, longitude: 13.7762741 }
    assert_response :success
  end
  
  test "GET /stories/nearby?latitude=56.161931&longitude=13.7762741 with unvalid api-key should return status 400" do
    assert_routing({ method: 'get', path: '/stories/nearby' }, { controller: "stories", action: "nearby" }) 
    
    get :nearby, { 'api-key' => "Q1W2E3R4T5Y", latitude: 56.161931, longitude: 13.7762741 }
    assert_response :bad_request
  end
  
  test "POST /stories without auth-token should return status 400" do
    assert_routing({ method: 'post', path: '/stories' }, { controller: "stories", action: "create" }) 
    post :create, { 'api-key' => Application.first.api_key, name: "Kärleksståry", description: "Puss och gull och kram", latitude: 56.1246963, longitude: 13.7400308 }
    assert_response :bad_request
  end
  
  test "POST /stories with valid api-key and auth-token and valid data should return status 201" do
    @controller = SessionsController.new
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    @controller = StoriesController.new
    assert_routing({ method: 'post', path: '/stories' }, { controller: "stories", action: "create" }) 
    post :create, { story_id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'], name: "Kärleksståry", description: "Puss och gull och kram", latitude: 56.1246963, longitude: 13.7400308 }
    assert_response :created
  end
  
  test "POST /stories/1/tags without auth-token should return status 400" do
    assert_routing({ method: 'post', path: '/stories/1/tags' }, { controller: "stories", action: "add_tags", story_id: "1" }) 
    post :add_tags, { story_id: "1", 'api-key' => Application.first.api_key, 'tag-ids' => '[1,2]' }
    assert_response :bad_request
  end
  
#  test "POST /stories/1/tags with valid api-key and auth-token and valid data should return status 200" do
#    @controller = SessionsController.new
#    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
#    
#    response = JSON.parse(@response.body)
#    @controller = StoriesController.new
#
#    assert_routing({ method: 'post', path: '/stories/1/tags' }, { controller: "stories", action: "add_tags", story_id: "1" })
#    post :add_tags, { story_id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'], 'tag-ids' => '[1,2]' }
#    assert_response :success
#  end
  
  test "PUT /stories/1 without auth-token should return status 400" do
    assert_routing({ method: 'put', path: '/stories/1' }, { controller: "stories", action: "update", id: "1" }) 
    put :update, { id: "1", 'api-key' => Application.first.api_key, name: "Kärleksståry", description: "Puss och gull och kram", latitude: 56.1246963, longitude: 13.7400308 }
    assert_response :bad_request
  end
  
#  test "PUT /stories/1 with valid api-key and auth-token and valid data should return status 200" do
#    @controller = SessionsController.new
#    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
#    response = JSON.parse(@response.body)
    
#    @controller = StoriesController.new
#    assert_routing({ method: 'put', path: '/stories/1' }, { controller: "stories", action: "update", id: "1" }) 
#    put :update, { id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'], name: "Love story", description: "Kisses, snuggles and hugs", latitude: 56.124696, longitude: 13.740030 }
#    assert_response :success
#  end
  
  test "DELETE /stories/1 with valid api_key but unvalid auth-token should return status 403" do
    @controller = SessionsController.new
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    
    @controller = StoriesController.new
    assert_routing({ method: 'delete', path: '/stories/1' }, { controller: "stories", action: "destroy", id: "1" }) 
    delete :destroy, { id: "1", 'api-key' => Application.first.api_key }
    assert_response :bad_request
  end
  
  test "DELETE /stories/1 with valid api_key but logged in as someone else should return status 403" do
    @controller = SessionsController.new
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.two@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    @controller = StoriesController.new
    assert_routing({ method: 'delete', path: '/stories/1' }, { controller: "stories", action: "destroy", id: "1" }) 
    delete :destroy, { id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'] }
    assert_response :forbidden
  end
  
  test "DELETE /stories/1 with valid api_key and valid auth-token should return status 200" do
    @controller = SessionsController.new
    post :authenticate, { 'api-key' => Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    response = JSON.parse(@response.body)
    @controller = StoriesController.new
    assert_routing({ method: 'delete', path: '/stories/1' }, { controller: "stories", action: "destroy", id: "1" }) 
    delete :destroy, { id: "1", 'api-key' => Application.first.api_key, 'auth-token' => response['auth_token'] }
    assert_response :success
  end
end