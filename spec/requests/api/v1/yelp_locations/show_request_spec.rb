require 'rails_helper'

RSpec.describe 'yelp_locations#show', :vcr do
  let(:business) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { business[:data] }

  context 'with valid params' do
    it 'renders locations information' do
      get api_v1_yelp_location_path(id: "raXi6598v97VVJGxuet_ZQ")

      expect(response).to be_successful

      expect(data).to_not be_empty
      expect(data.size).to eq(7)
    end
  end

  context 'with invalid params' do
    it 'rejects invalid id' do
      get api_v1_yelp_location_path(id: 1)

      expect(response).to_not be_successful
    end
  end
end
