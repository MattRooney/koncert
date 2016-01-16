class BandsInTownService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://api.bandsintown.com/")
  end

  def events(location)
    url_location = location.gsub(" ", "%20")
    parse_json(connection.get("events/search.json?location=#{url_location}&app_id=KONCERT"))
  end

  def on_sale_soon
    events = parse_json(connection.get("events/on_sale_soon.json?app_id=KONCERT"))
    events.sample(5)
  end

  private

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
