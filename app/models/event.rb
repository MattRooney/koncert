class Event
  def self.service
    @service ||= BandsInTownService.new
  end

  def self.by_location(location)
    service.events(location).map { |event| build_object(event) }
  end

  def self.next_three_days(location)
    three_days_events = []
    by_location(location)
    .each do |event|
      if Time.now <= event[:datetime].to_time && event[:datetime].to_time >= 3.days.from_now
        three_days_events << event
      end
      three_days_events
    end
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end

end
