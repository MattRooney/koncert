class Event
  def self.service
    @service ||= BandsInTownService.new
  end

  def self.all(location)
    service.events(location).map { |song| build_object(song) }
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end

end
