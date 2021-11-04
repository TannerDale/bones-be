class YelpClient
  class << self
    def find_locations(location)
      parse_data(conn.get(nearby_locations_url(location)))
    end

    def location_by_id(id)
      parse_data(conn.get("/v3/businesses/#{id}"))
    end

    def nearby_locations_url(location)
      "/v3/businesses/search?term=dog+friendly&categories=restaurants,bars&open_now=true&sort_by=distance&location=#{location}"
    end

    def conn
      Faraday.new("https://api.yelp.com", headers: { 'Authorization' => "bearer #{ENV['yelp_api_key']}" })
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
