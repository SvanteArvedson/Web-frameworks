require 'test_helper'

class CreatorsControllerTest < ActionController::TestCase
  
  test "GET /creators with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/creators' }, { controller: "creators", action: "index" }) 
    get :index, { api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /creators should return status 200" do
    assert_routing({ method: 'get', path: '/creators' }, { controller: "creators", action: "index" }) 
    get :index, { api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "GET /creators/1 with unvalid api_key should return status 400" do
    assert_routing({ method: 'get', path: '/creators/1' }, { controller: "creators", action: "show", id: "1" }) 
    get :show, { id: "1", api_key: "Q1W2E3T5Y1" }
    assert_response :bad_request
  end
  
  test "GET /creators/1 should return status 200" do
    assert_routing({ method: 'get', path: '/creators/1' }, { controller: "creators", action: "show", id: "1" }) 
    get :show, { id: "1", api_key: "Q1W2E3R4T5Y1" }
    assert_response :success
  end
  
  test "POST /creators with valid api_key but with unvalid data should return status 400" do
    assert_routing({ method: 'post', path: '/creators' }, { controller: "creators", action: "create" }) 
    post :create, { api_key: "Q1W2E3R4T5Y1", email: "creator.new@example.com", password: "hemligt", password_confirmation: "heligt" }
    assert_response :bad_request
  end
  
  test "POST /creators with valid api_key and valid data should return status 201" do
    assert_routing({ method: 'post', path: '/creators' }, { controller: "creators", action: "create" }) 
    post :create, { api_key: Application.first.api_key, email: "creator.new@example.com", password: "hemligt", password_confirmation: "hemligt" }
    assert_response :created
  end
  
end
