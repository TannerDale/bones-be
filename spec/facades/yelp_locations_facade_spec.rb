require 'rails_helper'

RSpec.describe 'yelp facade', :vcr do
  it 'yelp locations facade does stuff' do
    location = 'Denver'

    results = YelpLocationsFacade.dog_friendly_businesses(location)

    expect(results).to be_an Array

    first_result = results.first

    expect(first_result.count).to eq(3)

    expect(first_result).to have_key(:name)
    expect(first_result).to have_key(:address)
    expect(first_result).to have_key(:phone)

    expect(first_result).not_to have_key(:id)
    expect(first_result).not_to have_key(:rating)
  end
end
