require 'rails_helper'

RSpec.describe 'user_dogs#index' do
  it 'can get all dogs from a user id' do
    create_list(:dog, 3, user_id: 1)

    get '/api/v1/user_dogs?user_id=1'

    expect(response).to be_successful

    dogs = JSON.parse(response.body, symbolize_names: true)
    expect(dogs).to be_a(Hash)
    expect(dogs[:data]).to be_an(Array)
    expect(dogs[:data].size).to eq(3)
  end

  context 'with invalid params' do
    it 'has missing params' do
      get '/api/v1/user_dogs?user_id='

      expect(response.status).to eq(400)
    end

    it 'has empty params' do
      get '/api/v1/user_dogs'

      expect(response.status).to eq(400)
    end
  end
end
