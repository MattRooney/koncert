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
             "expires_at"=>2452725196,
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

    assert_equal ["Blackbird", "Hotline Bling", "What do you mean?", "Hello"],
      cleaned_tracks
  end

  test "#clean_tracks on removes nil tracks" do
    tracks = ["Blackbird", "Hotline Bling", "What do you mean?", "Hello"]
    cleaned_tracks = service.clean_tracks(tracks)

    assert_equal ["Blackbird", "Hotline Bling", "What do you mean?", "Hello"],
      cleaned_tracks
  end

  test "#total_artists_followed" do
    VCR.use_cassette("spotify_service#user") do

      assert_equal 20, service.total_artists_followed
    end
  end

  test "#following?" do
    VCR.use_cassette("spotify_service#following") do

      assert_equal true, service.following?("Sean Rowe").first
    end
  end

  test "#playlists" do
    VCR.use_cassette("spotify_service#playlists") do

      assert service.playlists
      assert_kind_of Array, service.playlists
      refute service.playlists.count.nil?
      assert service.playlists.first.name.include?("Koncert")
    end
  end

  test "#find_playlist" do
    VCR.use_cassette("spotify_service#find_playlist") do

      playlist = service.find_playlist("heyitsroon", "5IKwTyag2hi4ystmKGWT83")

      assert_equal "Ghost B.C. – Meliora", playlist.name
      assert_equal "5IKwTyag2hi4ystmKGWT83", playlist.id
    end
  end

  test "#create_playlist" do
    VCR.use_cassette("spotify_service#create_playlist") do
      service.create_playlist("Koncert Test Title")

      assert_equal "Koncert Test Title", service.playlists.first.name
    end
  end

  test "#top_tracks" do
    VCR.use_cassette("spotify_service#top_tracks") do
      track = service.top_tracks(["Rick Astley"]).first

      assert_equal "Never Gonna Give You Up", track.name
    end
  end

  test "#clean_artists" do
    VCR.use_cassette("spotify_service#clean_artists") do
      artists = service.clean_artists(["Rick Astley", "Andrew Carmer, Turing Instructor"])

      assert_equal 1, artists.count
      assert_equal "Rick Astley", artists.first
    end
  end

  test "#add_tracks" do
    VCR.use_cassette("spotify_service#add_tracks") do

      playlist = service.find_playlist("heyitsroon", "5IKwTyag2hi4ystmKGWT83")
      assert_equal 'Deus In Absentia', playlist.tracks.last.name

      tracks = [service.top_tracks(["Rick Astley"]).first]
      service.add_tracks(playlist, tracks)

      assert_equal "Never Gonna Give You Up", playlist.tracks.last.name
    end
  end
end
