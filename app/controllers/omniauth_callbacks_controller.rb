class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line; basic_action end

  private

  def basic_action
    # コールバックされた値を取得
    @omniauth = request.env['omniauth.auth']
        
    if @omniauth.present?
      # 登録済みユーザーであれば、ユーザー情報を@profileへ格納
      @profile = User.where(line_uid: @omniauth['uid']).first


      if @profile
        # プロフィール情報を最新に更新
        @profile.set_values(@omniauth)
        sign_in(:user, @profile)

      else
        # ユーザー情報を新規作成して、ログインユーザーとして扱う
        # email,passwordはdeviseで必須のため、ダミーでセット
        @profile = current_user || User.create!(
          line_uid: @omniauth['uid'], 
          email:    User.dummy_email(@omniauth),
          encrypted_password: Devise.friendly_token[0, 20]
        )
        
        # uid 以外のユーザー情報を保存する
        @profile.set_values(@omniauth)
        sign_in(:user , @profile)
      end
    end

    flash[:notice] = "ログインしました"
    redirect_to user_path(@profile)
  end

  # ダミーアドレス作成メソッド
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
