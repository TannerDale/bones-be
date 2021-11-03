require 'rails_helper'

RSpec.describe 'new pet' do
  it "can create a new pet" do
    pet_params = ({
                    name: 'Butters',
                    user_id: 1000,
                    size: 0,
                    breed: 'French Bulldog',
                    vaccinated: 1,
                    trained: 0,
                    sex: 'Male',
                    age: 2
                  })

    headers = {'CONTENT_TYPE': 'application/json'}

    post '/api/v1/pets/', headers: headers, params: JSON.generate(object: pet_params)

    expect(response).to be_successful

    pet = Pet.all.last

    expect(Pet.count).to eq(1)
    expect(pet.name).to eq(pet_params[:name])
  end

  it "missing param returns 404" do
    pet_params = ({
                    user_id: 1000,
                    size: 0,
                    breed: 'French Bulldog',
                    vaccinated: 1,
                    trained: 0,
                    sex: 'Male',
                    age: 2
                  })

    headers = {'CONTENT_TYPE': 'application/json'}

    post '/api/v1/pets/', headers: headers, params: JSON.generate(pet: pet_params)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
  end
end
