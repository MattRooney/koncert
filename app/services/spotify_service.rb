class SpotifyService
  attr_reader :client, :top_track

  def initialize(user_hash)
    @client = RSpotify::User.new(user_hash)
  end

  def profile_image
    client.images.first["url"]
  end

  def total_followers
      client.followers["total"]
  end

  def artists_followed
    client.following(type: "artist")
  end

  def total_artists_followed
    artists_followed.count
  end

  def following?(artist)
    client.follows?(RSpotify::Artist.search(artist).first)
  end

  def playlists
    client.playlists
  end

  def find_playlist(spotify_id, playlist_id)
    RSpotify::Playlist.find(spotify_id, playlist_id)
  end

  def create_playlist(title)
    client.create_playlist!(title)
  end

  def top_tracks(artists)
    top_tracks = artists.map do |artist|
        RSpotify::Artist.search(artist).first.top_tracks(:us).first
    end
    top_tracks
  end

  def clean_artists(artists)
    artists.delete_if { |artist| RSpotify::Artist.search(artist).empty? }
  end

  def clean_tracks(tracks)
    tracks.delete_if { |track| track == nil }
  end

  def add_tracks(playlist, tracks)
    playlist.add_tracks!(tracks)
  end
end
