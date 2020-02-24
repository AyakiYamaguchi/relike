class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :omniauthable, omniauth_providers: [:line, :twitter]

  has_many :remind_lists

  # deviseのパスワードのバリデーションを無効化する
  def password_required?
    super if confirmed?
  end


  # LINEapiからの取得した情報をセットする
  def line_login(omniauth)
    self.line_access_token = omniauth['credentials']['token']
    self.line_refresh_token = omniauth['credentials']['refresh_token']
    self.name = omniauth['info']['name']
    self.save!
  end


  # Twitter 認証で取得した情報をセットする
  def link_with_twitter(omniauth)
    self.twitter_uid = omniauth['uid']
    self.twitter_access_token = omniauth['credentials']['token']
    self.twitter_access_secret = omniauth['credentials']['secret']
    self.save!
  end

  
end
