require 'test_helper'

class CreatorsControllerTest < ActionController::TestCase
  
  test "POST /creators with valid api_key and valid auth_token but with unvalid data should return status 400" do
    @controller = SessionsController.new
    assert_routing({ method: 'post', path: '/authenticate' }, { controller: "sessions", action: "authenticate" }) 
    post :authenticate, { api_key: Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    auth_message = JSON.parse(@response.body)
    
    @controller = CreatorsController.new
    assert_routing({ method: 'post', path: '/creators' }, { controller: "creators", action: "create" }) 
    post :create, { api_key: "Q1W2E3R4T5Y1", auth_token: auth_message['auth_token'], email: "creator.new@example.com", password: "hemligt", password_confirmation: "heligt" }
    assert_response :bad_request
  end
  
  test "POST /creators with valid api_key and valid auth_token with valid data should return status 201" do
    @controller = SessionsController.new
    assert_routing({ method: 'post', path: '/authenticate' }, { controller: "sessions", action: "authenticate" }) 
    post :authenticate, { api_key: Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    
    auth_message = JSON.parse(@response.body)
    
    @controller = CreatorsController.new
    assert_routing({ method: 'post', path: '/creators' }, { controller: "creators", action: "create" }) 
    post :create, { api_key: Application.first.api_key, auth_token: auth_message['auth_token'], email: "creator.new@example.com", password: "hemligt", password_confirmation: "hemligt" }
    assert_response :created
  end
  
end
