class DogFactFacade
  class << self
    def fetch_a_fact
      DogFactClient.fetch.first
    end
  end
end
