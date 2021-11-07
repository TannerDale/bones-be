class GoogleCalendarClient
  class << self
    def create_event(body, email, token)
      parse_data(post(token, body, email))
    end

    private

    # def conn(token)
    #   Faraday.new('https://googleapis.com') do |c|
    #   end
    # end

    def post(token, body, email)
      Faraday.post("https://googleapis.com/calendar/v3/calendars/#{email}/events") do |req|
        req.body = body
        req.headers['Authorization'] = "Bearer #{token}"
        req.headers['Content-Type'] = 'applcation/json'
      end
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
