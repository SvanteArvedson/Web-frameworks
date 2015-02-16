require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  test "POST /authenticate with unvalid api_key should return status 403" do
    assert_routing({ method: 'post', path: '/authenticate' }, { controller: "sessions", action: "authenticate" }) 
    post :authenticate, { email: "creator.one@example.com", password: "hemligt" }
    assert_response :forbidden
  end
  
  test "POST /authenticate with unvalid credentials should return status 401" do
    assert_routing({ method: 'post', path: '/authenticate' }, { controller: "sessions", action: "authenticate" }) 
    post :authenticate, { api_key: Application.first.api_key, email: "creator.one@example.com", password: "heligt" }
    assert_response :unauthorized
  end
  
  test "POST /authenticate with valid credentials should return status 200" do
    assert_routing({ method: 'post', path: '/authenticate' }, { controller: "sessions", action: "authenticate" }) 
    post :authenticate, { api_key: Application.first.api_key, email: "creator.one@example.com", password: "hemligt" }
    assert_response :success
  end
  
end
