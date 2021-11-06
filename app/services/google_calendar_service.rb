class GoogleCalendarService
  class << self
    def create_event(token, body)
      GoogleCalendarClient.create_event(token, calendar_body(body))
    end

    private

    def calendar_body(data)
      {
        kind: 'calendar#event',
        description: "playdate",
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
      }
    end
  end
end
