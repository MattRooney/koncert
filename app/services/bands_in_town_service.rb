class BandsInTownService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://api.bandsintown.com/")
  end

  def events(location)
    parse_json(connection.get("events/search.json?location=#{location}"))
  end


  # def boston_events
  #   Bandsintown::Event.search({
  #     :location => 'Boston, MA',
  #     :start_date => Time.now,
  #     :end_date => 1.week.from_now
  #   })
  # end

  private

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
