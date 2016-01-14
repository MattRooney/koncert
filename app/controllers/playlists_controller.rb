class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new
    binding.pry
    events = bandsintown_service.events(params[:playlist][:location])
    artists = events.map { |event| event[:artists].first[:name] }
    playlist = spotify_service.create_playlist(params[:playlist][:location])
    artists.map { |artist| spotify_service.top_track(artist) }
  end

  def show
    @playlist = "Playlist"
  end

end
