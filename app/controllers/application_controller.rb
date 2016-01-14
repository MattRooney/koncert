class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :spotify_service, :bandsintown_service

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def spotify_service
    RSpotify::authenticate(ENV["spotify_api_key"], ENV["spotify_api_secret"])
    @spotify_service ||= SpotifyService.new(session[:auth_info]) if session[:auth_info]
  end

  def bandsintown_service
    @bandsintown_service ||= BandsInTownService.new
  end

end
