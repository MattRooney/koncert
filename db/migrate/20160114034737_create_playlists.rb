class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :spotify_id
      t.string :image
      t.string :name
      t.string :owner
      t.string :uri
      t.string :tracks

      t.timestamps null: false
    end
  end
end
