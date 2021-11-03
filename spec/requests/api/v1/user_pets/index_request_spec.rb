require 'rails_helper'

RSpec.describe 'user_pets#index' do
  it "can get all pets from a user id" do
    create_list(:pet, 3, user_id: 1)

    get '/api/v1/user_pets?user_id=1'

    expect(response).to be_successful

    pets = JSON.parse(response.body, symbolize_names: true)
    expect(pets).to be_a(Hash)
    expect(pets[:data]).to be_an(Array)
    expect(pets[:data].size).to eq(3)
  end
end
