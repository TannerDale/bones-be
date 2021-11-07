class GoogleCalendarClient
  class << self
    def create_event(body, email, token)
      parse_data(post(token, body, email))
    end

    private

    def conn(token)
      Faraday.new('https://googleapis.com') do |c|
        c.authorization :Bearer, token
      end
    end

    def post(token, body, email)
      conn(token).post do |req|
        req.url "/calendar/v3/calendars/#{email}/events"
        req.body = body
      end
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
