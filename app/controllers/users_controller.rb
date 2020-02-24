class UsersController < ApplicationController
  before_action :logged_in? , only:[:signup_finish , :show]
  def signup
  end

  def signup_line
  end

  def signup_twitter
  end

  def signup_finish
    @today = Date.today.strftime("%Y%m%d")
    logger.debug(@today)
  end

  def show
    @user = User.find(params[:id])
  end
end
