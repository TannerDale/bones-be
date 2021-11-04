require 'rails_helper'

RSpec.describe YelpService, :vcr do
  it '#find_locations' do
    location = 'Denver'
    results = YelpService.find_locations(location)
    expect(results.size).to eq(20)
    expect(results).to be_a(Array)
    business = results.first
    expect(business).to have_key(:name)
    expect(business).to have_key(:location)
    expect(business[:location][:city]).to eq(location)
  end

  it 'can find locations with partial location data'
end
