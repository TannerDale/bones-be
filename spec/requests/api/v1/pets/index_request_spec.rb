require 'rails_helper'

RSpec.describe 'pet#index' do
  it "can get all pets from a user id" do
    create_list(:pet, 5, user_id: 2)
    create_list(:pet, 5, user_id: 3)

    get '/api/v1/pets?user_id=3'

    expect(response).to be_successful

    pets = JSON.parse(response.body, symbolize_names: true)
    expect(pets).to be_a(Hash)
    expect(pets[:data]).to be_an(Array)
    pets[:data].each do |pet|
      expect(pet).to have_key(:id)
      expect(pet[:id]).to be_an(String)
      expect(pet).to have_key(:attributes)
      expect(pet[:attributes]).to have_key(:name)
      expect(pet[:attributes][:name]).to be_a(String)
      expect(pet[:attributes]).to have_key(:size)
      expect(pet[:attributes][:size]).to be_a(String)
      expect(pet[:attributes]).to have_key(:age)
      expect(pet[:attributes][:age]).to be_a(Integer)
      expect(pet[:attributes]).to have_key(:breed)
      expect(pet[:attributes][:breed]).to be_a(String)
      expect(pet[:attributes]).to have_key(:sex)
      expect(pet[:attributes][:sex]).to be_a(String)
      expect(pet[:attributes]).to have_key(:trained)
      expect(pet[:attributes][:trained]).to be_a(String)
      expect(pet[:attributes]).to have_key(:vaccinated)
      expect(pet[:attributes][:vaccinated]).to be_a(String)

      expect(pet[:attributes]).to_not have_key(:created_at)
      expect(pet[:attributes]).to_not have_key(:updated_at)
    end

    results = pets[:data].map do |pet|
      pet[:attributes][:user_id]
    end
    expect(results).not_to include(3)
  end

  it 'gets items' do
    create_list(:pet, 25)

    get '/api/v1/pets?page=1'

    expect(response).to be_successful

    pets = JSON.parse(response.body, symbolize_names: true)

    expect(pets).to be_a(Hash)
    expect(pets[:data]).to be_an(Array)
    expect(pets[:data].size).to eq(20)
  end
end
