class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.create({email: params[:email], password: params[:password]})
    redirect_to root_path
  end

  def show
    actual_user = User.find(session[:user_id])
    if logged_in? && check_current_user?
      @current_user = User.find(session[:user_id])
      @events = @current_user.events
    else
      redirect_to user_path(actual_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end