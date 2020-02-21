class ApplicationController < ActionController::Base

  def logged_in?
    redirect_to root_path unless user_signed_in?
  end
end
