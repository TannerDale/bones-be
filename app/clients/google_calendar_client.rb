class GoogleCalendarClient
  class << self
    def create_event(token, body)
      parse_data(post(token, body))
    end
  end

  private

  def conn
    Faraday.new('https://googleapis.com')
  end

  def post(token, body)
    conn.post do |req|
      req.authorization :Bearer, token
      req.url '/calendar/v3/calendars/primary/events'
      req.headers['Content-Type'] = 'application/json'
      req.body = body
    end
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
