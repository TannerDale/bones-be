require 'rails_helper'

describe Api::V1::DogFactsController, :vcr do
  describe 'GET /v1/dog_facts' do
    let(:json) { JSON.parse(response.body, symbolize_names: true) }

    it 'gets a dog fact' do
      get api_v1_dog_facts_path

      expect(json).to have_key(:fact)
      expect(json[:fact]).to_not be_empty
      expect(json[:fact]).to be_a String
    end
  end
end
