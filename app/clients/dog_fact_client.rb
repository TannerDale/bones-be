class DogFactClient
  class << self
    def fetch
      parse_data(Faraday.get(url))
    end

    private

    def url
      'https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=1'
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
