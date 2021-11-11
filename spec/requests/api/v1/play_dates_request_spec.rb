require 'rails_helper'

describe Api::V1::PlayDatesController, :vcr do
  describe 'GET /v1/play_dates' do
    let!(:dogs) { create_list :dog, 5 }
    let!(:dog) { create :dog, user_id: 1 }

    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:data) { json[:data] }
    let(:attributes) { data[:attributes] }
    let(:pending_play_dates) { data[:attributes][:pending_play_dates] }
    let(:accepted_play_dates) { data[:attributes][:accepted_play_dates] }

    before :each do
      dogs[1..2].each do |d|
        create :play_date, creator_dog_id: dog.id, invited_dog_id: d.id
      end
      dogs[3..4].each do |d|
        create :play_date, creator_dog_id: d.id, invited_dog_id: dog.id, invite_status: 1
        create :play_date, creator_dog_id: d.id, invited_dog_id: dog.id, invite_status: 0
      end
    end

    it 'has all of the users pending invites' do
      get api_v1_play_dates_path, params: { user_id: 1, status: 'invited' }

      expect(data.size).to eq(2)
    end

    it 'has all of the users playdates' do
      get api_v1_play_dates_path, params: { user_id: 1, status: 'all' }

      expect(data.size).to eq(6)
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
          }
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

  describe 'PATCH /v1/play_date/:id' do
    let!(:play_date) { create :play_date }
    let(:params) do
      {
        creator_dog: play_date.creator_dog_id,
        invited_dog: play_date.invited_dog_id
      }
    end
    let(:creator_dog) { play_date.creator_dog_id }
    let(:invited_dog) { play_date.invited_dog_id }

    context 'with valid params' do
      it 'updates the playdates invite status to accepted' do
        patch api_v1_play_date_path(play_date), params: params.merge({ status: 1 })

        play_date.reload

        expect(play_date.invite_status).to eq('accepted')
      end

      it 'deletes the playdate if the status is rejected' do
        id = play_date.id

        patch api_v1_play_date_path(play_date), params: params.merge({ status: 2 })

        expect(PlayDate.where(id: id)).to be_empty
      end
    end

    context 'with invalid params' do
      it 'returns 400 if no status' do
        patch api_v1_play_date_path(play_date), params: params

        expect(response).to have_http_status 400
      end

      it 'returns 400 if status isnt 1 or 2' do
        patch api_v1_play_date_path(play_date), params: params.merge({ status: 3 })

        expect(response).to have_http_status 400
      end

      it 'returns 400 if playdate is not found' do
        patch api_v1_play_date_path(play_date), params: params.merge({ status: 3, creator_dog_id: 111_111 })

        expect(response).to have_http_status 400
      end
    end
  end

  describe 'GET /v1/play_dates/:id' do
    let!(:dog1) { create :dog, user_id: 1 }
    let!(:dog2) { create :dog, user_id: 1 }
    let!(:play_date) { create :play_date, creator_dog_id: dog1.id, invited_dog_id: dog2.id }
    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:data) { json[:data] }

    context 'with a valid play_date id' do
      before { get api_v1_play_date_path(play_date.id) }

      it 'has the info for the play_date' do
        expect(data[:id].to_i).to eq(play_date.id)
        expect(data[:attributes].size).to eq(4)
      end
    end

    context 'with invalid play date id' do
      before { get api_v1_play_date_path(1_929_394_029_301) }

      it 'returns 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
