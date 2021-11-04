class YelpClient
  class << self
    def find_locations(location)
      parse_data(request(location))
    end

    def request(location)
      Faraday.get do |req|
        req.headers['Authorization'] = "bearer #{ENV['yelp_api_key']}"
        req.url "https://api.yelp.com/v3/businesses/search?term=dog+friendly&categories=restaurants,bars&open_now=true&sort_by=distance&location=#{location}"
      end
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
