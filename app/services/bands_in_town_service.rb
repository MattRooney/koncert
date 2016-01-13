class BandsInTownService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://api.bandsintown.com/")
  end

  def events(city)
    parse_json(connection.get("events/search.json?location=#{city}"))
  end

  private

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
