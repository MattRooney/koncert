class PlaylistsController < ApplicationController

  def index
  end

  def new
  end

  def create
    playlist = Playlist.new
    artists = playlist.artists(bandsintown_service.events(params[:playlist][:location]))
    spotify_artists = artists.delete_if { |artist| RSpotify::Artist.search(artist).empty? }

    top_tracks = spotify_artists.map do |artist|
        RSpotify::Artist.search(artist).first.top_tracks(:us).first
    end

    spotify_tracks = playlist.clean_tracks(top_tracks)
    spotify_playlist = spotify_service.create_playlist(params[:playlist][:location]+" #{Time.now.strftime("%m/%d/%Y")}")
    spotify_playlist.add_tracks!(spotify_tracks)

    redirect_to playlist_path(spotify_playlist.id)
  end

  def show
    @playlist = spotify_service.playlists.first
  end

  def destroy

  end

end
