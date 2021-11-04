require 'rails_helper'

RSpec.describe YelpService, :vcr do
  let(:location) { 'Denver' }
  let(:id) { 'RTvR4W7K-59xFFZAUTMTbQ' }

  it '#find_locations' do
    results = YelpService.find_locations(location)
    expect(results.size).to eq(20)
    expect(results).to be_a(Array)
    business = results.first
    expect(business).to have_key(:name)
    expect(business).to have_key(:location)
    expect(business[:location][:city]).to eq(location)
  end

  it '#find_location_by_id' do
    results = YelpService.find_location_by_id(id)
    expect(results).to be_a Hash
    expect(results).to_not be_empty
    expect(results).to have_key(:id)
    expect(results[:id]).to eq(id)
  end
end
