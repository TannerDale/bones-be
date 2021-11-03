require 'rails_helper'

RSpec.describe 'new pet' do
  it "can create a new pet" do
    pet_params = ({
      name: 'Butters',
      user_id: 1000,
      size: 0,
      breed: 'French Bulldog',
      vaccinated: true,
      trained: false,
      sex: 'Male',
      age: 2
      })
    headers = {'CONTENT_TYPE': 'application/json'}
    post '/api/v1/pets/', headers: headers, params: JSON.generate(pet: pet_params)
    expect(response).to be_successful

    pet = JSON.parse(response.body, symbolize_names: true)

    expect(pet[:data].size).to eq(3)
    expect(pet[:data]).to have_key(:id)
    expect(pet[:data]).to have_key(:type)
    expect(pet[:data]).to have_key(:attributes)

    expect(pet[:data][:attributes]).to have_key(:name)
    expect(pet[:data][:attributes]).to have_key(:size)
    expect(pet[:data][:attributes]).to have_key(:age)
    expect(pet[:data][:attributes]).to have_key(:breed)
    expect(pet[:data][:attributes]).to have_key(:sex)
    expect(pet[:data][:attributes]).to have_key(:trained)
    expect(pet[:data][:attributes]).to have_key(:vaccinated)
    expect(pet[:data][:attributes]).to have_key(:user_id)
  end

  it "missing param returns 404" do
    pet_params = ({
      user_id: 1000,
      size: 0,
      breed: 'French Bulldog',
      vaccinated: true,
      trained: false,
      sex: 'Male',
      age: 2
      })
    headers = {'CONTENT_TYPE': 'application/json'}
    post '/api/v1/pets/', headers: headers, params: JSON.generate(pet: pet_params)

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)
  end
end
