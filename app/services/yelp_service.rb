class YelpService
  class << self
    def find_locations(location)
      YelpClient.find_locations(location)[:businesses]
    end

    def find_location_by_id(id)
      data = YelpClient.location_by_id(id)

      raise ActiveRecord::RecordNotFound if data.key?(:error)

      data
    end
  end
end
