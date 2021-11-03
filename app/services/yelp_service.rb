class YelpService
  class << self
    def find_locations(location)
      results = YelpClient.find_locations(location)
      results[:businesses]
    end
  end
end
