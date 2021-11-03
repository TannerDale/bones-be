class YelpLocationsFacade
  def self.dog_friendly_businesses(location)
    business_data = YelpService.find_locations(location)

    info = business_data.map do |business|
      { name: business[:name],
      address: business[:location][:display_address],
      phone: business[:display_phone] }
    end
  end
end
