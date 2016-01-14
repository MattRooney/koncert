require 'rspotify'

class PlaylistsController < ApplicationController

  def new
    @playlist = Playlist.new(location)
  end

end
