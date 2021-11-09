require 'rails_helper'

describe PlayDateFacade, :vcr do
  let!(:dog1) { create :dog, user_id: 1 }
  let!(:dog2) { create :dog, user_id: 2 }
  let!(:pending) { create_list :play_date, 2, creator_dog_id: dog1.id, invited_dog_id: dog2.id }
  let!(:invited) { create_list :play_date, 2, creator_dog_id: dog2.id, invited_dog_id: dog1.id }

  it 'gets the users pending invites' do
    expect(PlayDateFacade.user_play_dates({ status: 'invited', user_id: 1 }).size).to eq(2)
  end

  it 'gets all the users playdates' do
    expect(PlayDateFacade.user_play_dates({ status: 'all', user_id: 1 }).size).to eq(4)
  end
end
