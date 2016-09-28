require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  test "authentication success" do
    get stores_url, env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'password')}
    assert_response :success
    assert_equal 'application/json', @response.content_type
    assert JSON.parse(@response.body)['stores'].count == 2
  end

  test "authentication failure with incorrect password" do
    get stores_url, env: {'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(users(:first_user).name, 'incorrect password')}
    assert_response :forbidden
  end
end
