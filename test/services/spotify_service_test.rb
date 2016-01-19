require './test/test_helper'

class SpotifyServiceTest < ActiveSupport::TestCase
  attr_reader :service, :test_user_hash

  def create_user
    @test_user_hash = {
      "provider"=>"spotify",
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
  end

  def setup
    create_user
    RSpotify::authenticate(ENV["spotify_api_key"], ENV["spotify_api_secret"])
    @service = SpotifyService.new(test_user_hash)
  end

  test "#profile_image" do

    assert service.profile_image
  end

  test "#total_followers" do

    assert_equal 20, service.total_followers
  end

  test "#clean_tracks" do
    tracks = ["Blackbird", "Hotline Bling", "What do you mean?", nil, "Hello"]
    cleaned_tracks = service.clean_tracks(tracks)

    assert_equal ["Blackbird", "Hotline Bling", "What do you mean?","Hello"],
      cleaned_tracks
  end

  test "#total_artists_followed" do
    # VCR.use_cassette("spotify_service#user") do

      assert_equal 20, service.total_artists_followed
  end

  test "#following?" do
    # VCR.use_cassette("spotify_service#user") do

      assert_equal true, service.following?("Sean Rowe").first
  end

  test "#playlists" do
    assert service.playlists
    assert_kind_of Array, service.playlists
    refute service.playlists.count.nil?
  end

  # test "#create_playlist" do
  #   number_of_playlists = service.playlists.count
  #
  #   service.create_playlist("Title")
  #   assert_equal number_of_playlists + 1, service.playlists.count
  # end

end
