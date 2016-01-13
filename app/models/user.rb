class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    binding.pry
    where(spotify_id: auth_info.info.id).first_or_create do |new_user|
      new_user.spotify_id         = auth_info.info.id
      new_user.name               = auth_info.info.display_name
      new_user.email               = auth_info.info.display_name
      new_user.name               = auth_info.info.display_name
      new_user.oauth_token        = auth_info.credentials.token
    end
  end
end
