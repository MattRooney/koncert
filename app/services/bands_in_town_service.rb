class BandsInTownService

  def self.events
    events = Bandsintown::Event.search({
      location: 'Denver, CO',
      start_date: Time.now,
      end_date: 1.week.from_now 
      })
  end
end
