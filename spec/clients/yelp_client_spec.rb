require 'rails_helper'

RSpec.describe YelpClient, :vcr do
  it 'returns results for a specific location' do
    location = 'Denver'
    result = YelpClient.find_locations(location)
    result = result[:businesses]
    expect(result.size).to eq(20)
    expect(result).to be_a(Array)
  end
end
