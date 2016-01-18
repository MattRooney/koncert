require 'test_helper'

class UserLogsInWithSpotifyTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = Koncert::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(
      { "provider"=>"spotify",
        "uid"=>nil,
        "info"=>
          {"birthdate"=>"1984-05-13",
           "country"=>"US",
           "display_name"=>"Matt Rooney",
           "email"=>"matthewjrooney@gmail.com",
           "external_urls"=>{"spotify"=>"https://open.spotify.com/user/heyitsroon"},
           "followers"=>{"href"=>nil, "total"=>20},
           "href"=>"https://api.spotify.com/v1/users/heyitsroon",
           "id"=>"heyitsroon",
           "images"=>
            [{"height"=>nil,
              "url"=>"https://scontent.xx.fbcdn.net/hprofile-xfa1/v/t1.0-1/p200x200/11889630_10153549975228827_8600060752847287950_n.jpg?oh=64bef2d69e40b96ad8db3aa8d84f46be&oe=5742708E",
              "width"=>nil}],
           "product"=>"premium",
           "type"=>"user",
           "uri"=>"spotify:user:heyitsroon"},
        "credentials"=>
          {"token"=>
            "BQCdnOSGI47FV9Pu5AJmbq7o0w1C8Sop2lDSV5RpUYFtYaPCx0dIUlD702NOqvgmewML4kUq2h7NUhUX-YEgap_MSpl5-0hivO7ypwQ-hQvTV9An5vG5_XoMbm9pnsi1NraHzeQD0LuVaFLdnwWBi_DOl-zY6Sb14IPoq1DuJfP2iSqEEW2n6ffCK5v0TXFN1D1oiksfkgO7Z7-euN5tg7bRpERnJON_DieCiMDlfMqt3-vsAEpGPXPZsdWw2YIEo7FeewsOK98TjFhY_iofKfwMWllX9AATkZ0lEpHInvkjizv2x-HP",
             "refresh_token"=>"AQA88LaUbIGXFaBPVeAOzIoMN4Ow7uR_sZaVCou0yOhY0hlc7x4ewr4vOHI9FDTTvAJN4rDfcjNM2O6ESzZgDqpZWGBUN1KwxwRksRd-_ropxvSYnaQCF14OzyH4j4avUGY",
             "expires_at"=>1452725196,
             "expires"=>true},
         "extra"=>{}}
         )
  end

  def login_user
    visit "/"

    assert_equal 200, page.status_code

    click_link "Sign in with Spotify"

    assert_equal "/users/980190963", current_path
    assert page.has_content?("Matt Rooney")
    assert page.has_content?("Followers")
    assert page.has_link?("Logout")
  end

  test "log in and log out" do
    login_user

    click_link "Logout"

    assert_equal "/", current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Login with Spotify")
  end
end
