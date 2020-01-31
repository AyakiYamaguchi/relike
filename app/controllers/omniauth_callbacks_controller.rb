class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!, only: [:twitter]
  

  def line
    @user = User.find_or_create_by(line_uid: request.env['omniauth.auth']['uid'])
    @user.line_login(request.env['omniauth.auth'])

    if @user.twitter_uid.blank?
      sign_in(:user , @user)
      redirect_to signup_twitter_path
    else
      sign_in(:user , @user)
      redirect_to remind_lists_path
    end
  end


  def twitter
    @user = current_user

    # Twitter連携が初めての場合と、連携済みの場合で処理を分岐させる
    if @user.twitter_uid.blank?
      @user.link_with_twitter(request.env['omniauth.auth'])
      RemindList.new.set_first_remind_tweet(@user)
      redirect_to signup_finish_path
    else
      @user.link_with_twitter(request.env['omniauth.auth'])
      redirect_to remind_lists_path
    end
    
  end

end
