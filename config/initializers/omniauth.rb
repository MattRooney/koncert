require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['your_client_id'], ENV['your_client_secret'], scope: 'user-read-email user-read-birthdate user-read-private user-library-modify user-library-read user-follow-read user-follow-modify streaming playlist-modify-private playlist-modify-public playlist-read-collaborative playlist-read-private'
end
