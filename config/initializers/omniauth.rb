require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "spotify_api_key", "spotify_api_secret",
            scope: 'playlist-read-private playlist-read-collaborative	playlist-modify-public	playlist-modify-private	streaming	user-follow-modify	user-follow-read'
end
