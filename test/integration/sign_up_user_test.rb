require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest
  def setup
    @valid_user_params = {username: "volodya", email: "volodya@example.com", password: "volodya"}
    @invalid_user_params = {username: "v", email: "volodya", password: "volodya"}
  end

  test 'get sign up form and create user' do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: @valid_user_params}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Welcome', response.body
    assert_match "#{@valid_user_params[:username]}", response.body
  end

  test 'get sign up form and reject user with invalid credentials' do
    get '/signup'
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: {user: @invalid_user_params}
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
  end

end
