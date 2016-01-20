require './test/test_helper'

class BandsInTownServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    @service = BandsInTownService.new
  end

  test "#events returns events for the correct region and time" do
    VCR.use_cassette("bandsintown_service#events") do
      events = service.events("Denver, CO")

      assert_equal 50, events.count
      assert_equal Time.now.day, events.first[:datetime].to_time.day
      assert_equal "CO", events.first[:venue][:region]
      assert_equal "CO", events.last[:venue][:region]
    end
  end

  test "#artists returns an array of artists one for each event" do
    VCR.use_cassette("bandsintown_service#events") do
      events = service.events("Denver, CO")
      artists = service.artists(events)

      assert_equal Array, artists.class
      assert_equal 49, artists.count
      # on Jan 20th there is one event labeled "/aritst is residence/"
    end
  end

  test "#on_sale_soon returns 5 events for the correct region and time" do
    VCR.use_cassette("bandsintown_service#on_sale_soon") do
      events = service.on_sale_soon

      assert_equal Array, events.class
      assert_equal 5, events.count
      assert_equal "CO", events.first[:venue][:region]
      assert_equal "CO", events.last[:venue][:region]
    end
  end
end
