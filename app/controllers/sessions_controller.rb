class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:current_user_id] = user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to root_url
    else
      flash.now[:alert] = 'There was something wrong with your credentials'
      render 'new', status: :bad_request
    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_url
  end
end
