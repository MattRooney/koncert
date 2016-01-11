class SpotifyService
  attr_reader :top_track

  def self.top_track(artist)
    @top_track = RSpotify::Artist.search('artist').first.top_tracks(:us).first
  end

  def add_to_playlist
    top_track
  end

end
