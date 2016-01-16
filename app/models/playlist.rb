class Playlist < ActiveRecord::Base

  def artists(events)
    artists = events.map { |event| event[:artists].first[:name] }
    artists.uniq!
  end

  def clean_tracks(tracks)
    spotify_tracks = tracks.delete_if { |track| track == nil }
  end
  
end
