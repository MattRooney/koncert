class AddLocationToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :location, :string
  end
end
