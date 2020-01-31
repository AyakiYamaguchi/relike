class UsersController < ApplicationController
  # before_action :authenticate_user!


  def signup_line
  end

  def signup_twitter
  end

  def signup_finish
    @today = Date.today.strftime("%Y%m%d")
  end

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def delete
  end
end
