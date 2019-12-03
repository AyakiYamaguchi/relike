class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :omniauthable, omniauth_providers: [:line]

  def set_values(omniauth)
    return if line_uid != omniauth['uid']
    credentials = omniauth['credentials']
    info = omniauth['info']

    self.line_access_token = credentials['token']
    self.line_refresh_token = credentials['refresh_token']
    self.name = info['name']
  end
  
end
