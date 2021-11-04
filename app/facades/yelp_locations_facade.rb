class YelpLocationsFacade
  def self.dog_friendly_businesses(location)
    business_data = YelpService.find_locations(location)

    info = business_data.map do |business|
      {
        id: business[:id],
        name: business[:name],
        address: business[:location][:display_address].join(', '),
        phone: business[:display_phone],
        rating: business[:rating]
      }
    end
  end
end
