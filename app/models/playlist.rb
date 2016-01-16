class Playlist < ActiveRecord::Base

  def bandsintown_service
    @bandsintown_service = BandsInTownService.new
  end

  def artists(events)
    artists = events.map { |event| event[:artists].first[:name] }
    artists.uniq
  end

  def clean_tracks(tracks)
    spotify_tracks = tracks.delete_if { |track| track == nil }
  end

  def events(location)
    bandsintown_service.events(location)
  end

end
