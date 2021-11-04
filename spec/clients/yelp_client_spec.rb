require 'rails_helper'

RSpec.describe YelpClient, :vcr do
  let(:location) { 'Denver' }
  let(:id) { 'RTvR4W7K-59xFFZAUTMTbQ' }

  it 'returns results for a specific location' do
    result = YelpClient.find_locations(location)

    expect(result).to be_a Hash
    expect(result).to have_key(:businesses)
    expect(result[:businesses]).to_not be_empty
  end

  it 'finds a location by id' do
    result = YelpClient.location_by_id(id)

    expect(result).to be_a Hash
    expect(result).to_not be_empty
  end
end
