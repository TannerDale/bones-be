require 'rails_helper'

RSpec.describe 'yelp_locations#index', :vcr do
  let(:locations) { JSON.parse(response.body, symbolize_names: true) }

  it 'can get all businesses from searched location' do
    get '/api/v1/yelp_locations?location=denver'

    expect(response).to be_successful
    expect(locations).to be_a(Hash)
    expect(locations[:data]).to be_an(Array)

    first_location = locations[:data].first

    expect(first_location).to be_a Hash
    
    expect(first_location).to have_key(:name)
    expect(first_location).to have_key(:address)
    expect(first_location).to have_key(:phone)
    expect(first_location).to have_key(:id)
    expect(first_location).to have_key(:rating)

    expect(first_location[:address]).to be_a String
    expect(first_location[:rating]).to be_an Float
  end
end
