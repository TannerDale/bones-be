class YelpService
  class << self
    def find_locations(location)
      YelpClient.find_locations(location)
    end
  end
end
