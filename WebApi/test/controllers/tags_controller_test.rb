require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  test "GET /tags with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/tags' }, { controller: "tags", action: "index" }) 
    get :index, { api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /tags should return status 200" do
    assert_routing({ method: 'get', path: '/tags' }, { controller: "tags", action: "index" }) 
    get :index, { api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /tags/1 with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/tags/1' }, { controller: "tags", action: "show", id: "1" }) 
    get :show, { id: "1", api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /tags/1 should return status 200" do
    assert_routing({ method: 'get', path: '/tags/1' }, { controller: "tags", action: "show", id: "1" }) 
    get :show, { id: "1", api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /tags/1/stories with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/tags/1/stories' }, { controller: "stories", action: "index", tag_id: "1" }) 
    get :index, { tag_id: "1", api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /tags/1/stories should return status 200" do
    assert_routing({ method: 'get', path: '/tags/1/stories' }, { controller: "stories", action: "index", tag_id: "1" }) 
    get :index, { tag_id: "1", api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
end
