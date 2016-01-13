class SpotifyService
  attr_reader :client, :top_track

  def initialize(user_hash)
    @client = RSpotify::User.new(user_hash)
  end

  def profile_image
    binding.pry
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

  def create_playlist(title)
    client.create_playlist!(title)
  end

  def top_track(artist)
    @top_track = RSpotify::Artist.search('artist').first.top_tracks(:us).first
  end

end
