require 'rspotify'

class PlaylistsController < ApplicationController

  def new
    @playlist = Playlist.new(location)
  end

  def show
    @playlist = "Playlist"
  end

end
