class PlaylistsController < ApplicationController

  def index
    # @playlists = spotify_service.playlists
  end

  def new
  end

  def create
    events = bandsintown_service.events(params[:playlist][:location])
    artists = bandsintown_service.artists(events)
    spotify_artists = spotify_service.clean_artists(artists)
    top_tracks = spotify_service.top_tracks(spotify_artists)
    spotify_tracks = spotify_service.clean_tracks(top_tracks)
    spotify_playlist = spotify_service.create_playlist("Koncert " + params[:playlist][:location] + " #{Time.now.strftime("%m/%d/%Y")}")
    spotify_service.add_tracks(spotify_playlist, spotify_tracks)
    redirect_to playlist_path(spotify_playlist.id)
  end

  def show
    @playlist = spotify_service.find_playlist(current_user.spotify_id, params[:id])
    @events = bandsintown_service.playlist_events(@playlist.name.split[1, 2].join(" "))
  end

  def destroy
  end

end
