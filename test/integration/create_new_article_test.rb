require "test_helper"

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'johndoe', email: 'johndoe@example.com', password: 'password')
    sign_in_as(@user)
    @valid_article_params = {title: "Some new article title", description: 'Some new article description', user: @user}
    @invalid_article_params = {title: "v", description: "a", user: @user}
  end

  test 'get articles/new form and create user' do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: @valid_article_params}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Article was created successfully', response.body
    assert_match "#{@valid_article_params[:title]}", response.body
  end

  test 'get articles/new form and reject article with invalid params' do
    get '/articles/new'
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: @invalid_article_params}
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
  end

end
