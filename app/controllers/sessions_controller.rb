class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [ :new, :create ]

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    puts "Session is #{session[:user_id]}"
    flash[:success] = "You have successfully logged in!"
    redirect_to root_path
    else
      flash.now[:error] = "Invalid login credentials!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out successfully!"
    redirect_to login_path
  end

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in!"
      redirect_to root_path
    end
  end
end
