class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(spotify_id: auth_info[:info][:id]).first_or_create do |new_user|
      new_user.provider           = auth_info.provider
      new_user.spotify_id         = auth_info.info.id
      new_user.name               = auth_info.info.display_name
      new_user.email              = auth_info.info.email
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.refresh_token
    end
  end
end
