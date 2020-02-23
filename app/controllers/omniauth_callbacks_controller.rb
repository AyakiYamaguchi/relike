class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!, only: [:twitter]

  def line
    @user = User.find_or_create_by(line_uid: request.env['omniauth.auth']['uid'])
    @user.line_login!(request.env['omniauth.auth'])

    redirect_path = @user.twitter_uid.blank? ? signup_twitter_path : remind_lists_path
    sign_in(:user , @user)
    redirect_to redirect_path
  end

  def twitter
    # Twitter連携が初めての場合と、連携済みの場合で処理を分岐させる
    if current_user.twitter_uid.blank?
      current_user.link_with_twitter(request.env['omniauth.auth'])
      RemindList.new.set_first_remind_tweet(current_user)
      redirect_to signup_finish_path
    else
      current_user.link_with_twitter(request.env['omniauth.auth'])
      redirect_to remind_lists_path
    end
  end
end
