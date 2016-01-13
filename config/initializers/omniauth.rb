require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_api_key"], ENV["spotify_api_secret"],  scope: 'user-read-email'
end
