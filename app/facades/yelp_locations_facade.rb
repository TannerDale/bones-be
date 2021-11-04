class YelpLocationsFacade
  class << self
    def dog_friendly_businesses(location)
      YelpService.find_locations(location).map do |business|
        format_business_data(business)
      end
    end

    def find_location_by_id(id)
      format_business_data(YelpService.find_location_by_id(id))
    end

    private

    def find_category_titles(categories)
      categories.map { |category| category[:title] }
    end

    def format_business_data(business)

      {
        id: business[:id],
        name: business[:name],
        address: business[:location][:display_address].join(', '),
        phone: business[:display_phone],
        rating: business[:rating],
        categories: find_category_titles(business[:categories]),
        image_url: business[:image_url]
      }
    end
  end
end
