require 'rails_helper'

RSpec.describe 'dog#index' do
  it 'can get all dogs from a user id' do
    create_list(:dog, 5, user_id: 2)
    create_list(:dog, 5, user_id: 3)

    get '/api/v1/dogs?user_id=3'

    expect(response).to be_successful

    dogs = JSON.parse(response.body, symbolize_names: true)
    expect(dogs).to be_a(Hash)
    expect(dogs[:data]).to be_an(Array)
    dogs[:data].each do |dog|
      expect(dog).to have_key(:id)
      expect(dog[:id]).to be_an(String)
      expect(dog).to have_key(:attributes)
      expect(dog[:attributes]).to have_key(:name)
      expect(dog[:attributes][:name]).to be_a(String)
      expect(dog[:attributes]).to have_key(:size)
      expect(dog[:attributes][:size]).to be_a(String)
      expect(dog[:attributes]).to have_key(:age)
      expect(dog[:attributes][:age]).to be_a(Integer)
      expect(dog[:attributes]).to have_key(:breed)
      expect(dog[:attributes][:breed]).to be_a(String)
      expect(dog[:attributes]).to have_key(:sex)
      expect(dog[:attributes][:sex]).to be_a(String)
      expect(dog[:attributes]).to have_key(:trained)
      expect(dog[:attributes][:trained]).to be_a(String)
      expect(dog[:attributes]).to have_key(:vaccinated)
      expect(dog[:attributes][:vaccinated]).to be_a(String)

      expect(dog[:attributes]).to_not have_key(:created_at)
      expect(dog[:attributes]).to_not have_key(:updated_at)
    end

    results = dogs[:data].map do |dog|
      dog[:attributes][:user_id]
    end
    expect(results).not_to include(3)
  end

  it 'gets items' do
    create_list(:dog, 25)

    get '/api/v1/dogs?page=1'

    expect(response).to be_successful

    dogs = JSON.parse(response.body, symbolize_names: true)

    expect(dogs).to be_a(Hash)
    expect(dogs[:data]).to be_an(Array)
    expect(dogs[:data].size).to eq(20)
  end
end
