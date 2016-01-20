require 'test_helper'

class UserLogsInWithSpotifyTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = Koncert::Application
    stub_omniauth
  end

  test "log in and log out" do
    login_user

    click_link "Logout"

    assert_equal "/", current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Login with Spotify")
  end

  test "logged in user sees shows on sale soon and links to tickets" do
    login_user

    assert page.has_content? "On Sale Soon"

    within("#on-sale-card") do
      first(".avatar") do
        assert page.has_content?("Tickets")
      end
    end
  end

  test "logged in user sees shows on sale soon in their area" do
    login_user

    assert page.has_content? "On Sale Soon"

    within("#on-sale-card") do
      first(".avatar") do
        assert page.has_content?("CO")
      end
    end
  end

end
