class UsersController < ApplicationController
  before_action :find_user_with_params_id, only: %i[edit update]

  def new
    @user = User.new
  end

  def edit; end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to articles_path
      flash[:notice] = 'Profile has been updated'
    else
      render 'edit', status: :bad_request
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog, #{@user.username}, you have successfully signed up"
      redirect_to articles_path
    else
      render 'new', status: :bad_request
    end
  end

  private

  def find_user_with_params_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
