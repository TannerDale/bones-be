class GoogleCalendarService
  class << self
    def create_event(body)
      GoogleCalendarClient.create_event(calendar_body(body), body[:email], body[:token])
    end

    private

    def calendar_body(data)
      {
        kind: 'calendar#event',
        description: 'playdate',
        creator: {
          self: true
        },
        start: {
          dateTime: data[:start_time],
          timeZone: data[:timezone]
        },
        end: {
          dateTime: data[:end_time],
          timeZone: data[:timezone]
        },
        attendees: [
          {
            email: data[:invited_email]
          }
        ]
      }.to_json
    end
  end
end
