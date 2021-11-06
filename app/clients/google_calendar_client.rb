class GoogleCalendarClient
  class << self
    def create_event(user, body)

    end
  end

  private

  def conn
    Faraday.new('https://googleapis.com')
  end
end
