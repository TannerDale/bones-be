class YelpService
  class << self
    def find_locations(location)
      YelpClient.find_locations(location)[:businesses]
    end

    def find_location_by_id(id)
      data = YelpClient.location_by_id(id)

      if data.key?(:error)
        raise ActiveRecord::RecordNotFound
      else
        data
      end
    end
  end
end
