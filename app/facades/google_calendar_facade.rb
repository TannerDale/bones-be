class GoogleCalendarFacade
  class << self
    def create_event(token, body)
      GoogleCalendarService.create_event(token, body.merge(format_dates(body))
    end

    def format_dates(body)
      {
        start_time: format_start_date(body),
        end_time: format_end_date(body)
      }
    end

    def format_start_date(body)
      time = format_time(body[:time])
      "#{body[:date]}T#{time}"
    end

    def format_end_date(body)
      time = format_time(body[:time]).split(':')
      time[0] = time[0].to_i + 1
      "#{body[:date]}T#{time.join(':')}"
    end

    def format_time(time)
      time.gsub(/\s\w\w/, ':00')
    end
  end
end
