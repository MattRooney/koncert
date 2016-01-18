require 'test_helper'

class UserPlaylistsTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    Capybara.app = Koncert::Application
    stub_omniauth
    login_user
    @user = User.last
  end

  test "user sees playlists" do
    click_link "Your Playlists"

    assert_equal playlists_path, current_path

    within "#playlists-card" do
      assert page.has_content?("Your Playlists")
      assert page.has_css?("#playlist-link")
    end
  end

  test "user can create playlist" do
    click_link "Generate a Playlist"

    assert_equal new_playlist_path, current_path

    fill_in "City, ST", with: "Denver, CO"
    click_button "Generate Playlist"

    assert page.has_content?("Denver, CO #{Time.now.strftime("%m/%d/%Y")}")
  end
end
