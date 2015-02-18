require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  test "GET /stories with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/stories' }, { controller: "stories", action: "index" }) 
    get :index, { api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /stories should return status 200" do
    assert_routing({ method: 'get', path: '/stories' }, { controller: "stories", action: "index" }) 
    get :index, { api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /stories/1 with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/stories/1' }, { controller: "stories", action: "show", id: "1" }) 
    get :show, { id: "1", api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /stories/1 should return status 200" do
    assert_routing({ method: 'get', path: '/stories/1' }, { controller: "stories", action: "show", id: "1" }) 
    get :show, { id: "1", api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
end
