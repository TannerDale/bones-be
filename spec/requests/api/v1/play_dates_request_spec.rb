require 'rails_helper'

describe Api::V1::PlayDatesController, :vcr do
  describe 'GET /v1/play_dates' do
    let!(:dogs) { create_list :dog, 5 }
    let!(:dog) { dogs.first }

    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:data) { json[:data] }
    let(:attributes) { data[:attributes] }
    let(:play_dates) { data[:attributes][:play_dates] }

    before :each do
      dogs[1..2].each do |d|
        create :play_date, creator_dog_id: dog.id, invited_dog_id: d.id
      end
      dogs[3..4].each do |d|
        create :play_date, creator_dog_id: d.id, invited_dog_id: dog.id
      end
    end

    it 'has all the dogs playdates' do
      get api_v1_dog_play_dates_path(dog.id)
      expect(attributes.size).to eq(10)
      expect(play_dates.size).to eq(4)
    end
  end

  describe 'POST /v1/play_dates' do
    context 'with valid params' do
      let(:pd) { build :play_date }
      let(:dog1) { create :dog }
      let(:dog2) { create :dog }
      let(:valid_params) do
        {
          object: {
            creator_dog_id: dog1.id,
            invited_dog_id: dog2.id,
            location_id: pd.location_id,
            date: pd.date,
            time: pd.time
          },
          token: "ya29.a0ARrdaM-AFsR-_zubgYwerPzkVVNQvW1CQSg49GzgTOxRD4vTMtIta_F_JF6n7Bdlbr_61eFpliOoiFmZztGDqrk5MiTmpV57LMScjiY1gR94XeAH118HxnnnMUuHZErE4Wpn4iUbgdbjBcnc2wWs2HcAifCA"
        }
      end

      it 'creates the play date' do
        post api_v1_play_dates_path, params: valid_params

        expect(response).to have_http_status 204
        expect(PlayDate.count).to eq(1)
      end
    end

    context 'with invalid params' do
      let(:pd) { build :play_date }
      let(:dog1) { create :dog }
      let(:dog2) { create :dog }
      let(:valid_params) do
        {
          creator_dog_id: dog1.id,
          invited_dog_id: dog2.id,
          location_id: pd.location_id,
          date: pd.date,
          time: pd.time
        }
      end

      it '400s no created dog id' do
        post api_v1_play_dates_path, params: { object: valid_params.merge({ creator_dog_id: '' }) }

        expect(response.status).to eq(400)
        expect(PlayDate.count).to eq(0)
      end

      it '400s no invited dog id' do
        post api_v1_play_dates_path, params: { object: valid_params.merge({ invited_dog_id: '' }) }

        expect(response.status).to eq(400)
        expect(PlayDate.count).to eq(0)
      end

      it '400s no location id' do
        post api_v1_play_dates_path, params: { object: valid_params.merge({ location_id: '' }) }

        expect(response.status).to eq(400)
        expect(PlayDate.count).to eq(0)
      end

      it '400s no date' do
        post api_v1_play_dates_path, params: { object: valid_params.merge({ date: '' }) }

        expect(response.status).to eq(400)
        expect(PlayDate.count).to eq(0)
      end

      it '400s no time' do
        post api_v1_play_dates_path, params: { object: valid_params.merge({ time: '' }) }

        expect(response.status).to eq(400)
        expect(PlayDate.count).to eq(0)
      end
    end
  end
end
