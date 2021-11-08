require 'rails_helper'

RSpec.describe 'yelp facade', :vcr do
  let(:location) { 'Denver' }
  let(:id) { 'RTvR4W7K-59xFFZAUTMTbQ' }

  it 'dog friendly businesses' do
    results = YelpLocationsFacade.dog_friendly_businesses(location)

    expect(results).to be_an Array

    first_result = results.first

    expect(first_result.count).to eq(7)

    expect(first_result).to have_key(:name)
    expect(first_result).to have_key(:address)
    expect(first_result).to have_key(:phone)
    expect(first_result).to have_key(:id)
    expect(first_result).to have_key(:rating)

    expect(first_result).not_to have_key(:location)
    expect(first_result).not_to have_key(:url)
  end

  it 'finds business by id' do
    results = YelpLocationsFacade.find_location_by_id(id)

    expect(results).to be_a Hash
    expect(results.size).to eq(7)
  end
end
