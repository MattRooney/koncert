class PlaylistsController < ApplicationController

  def index
  end

  def new
    @playlist = Playlist.new
  end

  def create
    events = bandsintown_service.events(params[:playlist][:location])
    artists = events.map { |event| event[:artists].first[:name] }
    artists.uniq
    spotify_artists = artists.delete_if {|artist| RSpotify::Artist.search(artist).empty? }
    tracks = spotify_artists.map do |artist|
        RSpotify::Artist.search(artist).first.top_tracks(:us).first
    end
    spotify_tracks = tracks.delete_if { |track| track == nil }
    playlist = spotify_service.create_playlist(params[:playlist][:location]+" #{Time.now.strftime("%m/%d/%Y")}")
    found_playlist = RSpotify::Playlist.find(current_user.spotify_id, playlist.id)
    found_playlist.add_tracks!(spotify_tracks)
    redirect_to playlist_path(current_user.id)
  end

  def show
    @playlist = spotify_service.playlists.first
  end

  def destroy

  end

end
