class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(spotify_id: auth_info[:id]).first_or_create do |new_user|
      new_user.spotify_id         = auth_info.id
      new_user.name               = auth_info.name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end
end
