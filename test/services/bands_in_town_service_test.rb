require 'test_helper'

class BandsInTownServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    @service = BandsInTownService.new
  end

  test "#events returns for the correct location and time" do
    VCR.use_cassette("bandsintown_service#events") do
      events = service.events("Denver, CO")

      assert_equal 50, events.count
      assert_equal Time.now.day, events.first[:datetime].to_time.day
      assert_equal "CO", events.first[:venue][:region]
    end
  end
end
