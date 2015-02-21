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
  
  test "GET /search?query=Blodkorv should return status 200" do
    assert_routing({ method: 'get', path: '/search' }, { controller: "stories", action: "search" }) 
    
    get :search, { 'api-key' => "Q1W2E3R4T5Y1", query: "Blodkorv" }
    assert_response :success
  end
  
  test "GET /search?query=Blodkorv with unvalid api-key should return status 400" do
    assert_routing({ method: 'get', path: '/search' }, { controller: "stories", action: "search" }) 
    
    get :search, { 'api-key' => "Q1W2E3R4T5Y", query: "Blodkorv" }
    assert_response :bad_request
  end
end
