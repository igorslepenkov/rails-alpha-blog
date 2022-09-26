class UsersController < ApplicationController
  before_action :find_user_with_params_id, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index new create]
  before_action :authenticate_user, only: %i[edit update destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to users_path
      flash[:notice] = 'Profile has been updated'
    else
      render 'edit', status: :bad_request
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog, #{@user.username}, you have successfully signed up"
      redirect_to users_path
    else
      render 'new', status: :bad_request
    end
  end

  def destroy
    @user.destroy
    session[:current_user_id] = nil
    flash[:notice] = 'Account and all associated articles deleted'
    redirect_to root_path
  end

  private

  def find_user_with_params_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def authenticate_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = 'You can only edit or delete your own profile'
      redirect_to user_path(current_user)
    end
  end
end
