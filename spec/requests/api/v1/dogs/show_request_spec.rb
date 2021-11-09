require 'rails_helper'

describe 'Dogs Show' do
  let!(:dogs) { create_list :dog, 20 }
  let(:data) { JSON.parse(response.body, symbolize_names: true)[:data] }
  let(:attributes) { data[:attributes] }

  before :each do
    dogs[..-2].each_with_index do |dog, i|
      create :play_date, creator_dog_id: dog.id, invited_dog_id: dogs[i + 1].id, invite_status: [0, 1].sample
    end
  end

  it 'returns the dog with its play_dates' do
    get api_v1_dog_path(dogs.first)

    expect(response).to have_http_status 200
    expect(data).to have_key :id
    expect(data).to have_key :attributes
    expect(attributes[:accepted_play_dates]).to be_an Array
    expect(attributes[:pending_play_dates]).to be_an Array
  end
end
