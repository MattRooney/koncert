class PlaylistsController < ApplicationController

  def index
  end

  def new
    @playlist = Playlist.new
  end

  def create
    events = bandsintown_service.events(params[:playlist][:location])
    artists = events.map { |event| event[:artists].first[:name] }
    playlist = spotify_service.create_playlist(params[:playlist][:location])
    tracks = artists.uniq.map { |artist| spotify_service.top_track(artist) }
    playlist.add_tracks!(tracks)
    redirect_to playlist_path(@playlist)
  end

  def show
    playlist = spotify_service.playlists.first.uri
    @embed_code = ActiveSupport::SafeBuffer.new(%Q{<iframe src="https://embed.spotify.com/?uri=#{playlist}" width="300" height="380" frameborder="0" allowtransparency="true"></iframe>})
  end

end
