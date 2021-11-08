require 'rails_helper'

RSpec.describe PlayDate, type: :model do
  describe 'relationships' do
    it { should belong_to(:creator_dog) }
    it { should belong_to(:invited_dog) }
  end

  describe 'validations' do
    it { should validate_presence_of :location_id }
    it { should validate_presence_of :date }
    it { should validate_presence_of :time }
  end

  describe 'enums' do
    it { should define_enum_for(:invite_status).with_values(%i[pending accepted rejected]) }
  end

  describe 'pending invited play dates' do
    let!(:dog1) { create :dog, user_id: 1 }
    let!(:dog2) { create :dog, user_id: 2 }
    let!(:pending) { create_list :play_date, 2, creator_dog_id: dog1.id, invited_dog_id: dog2.id }
    let!(:invited) { create_list :play_date, 2, creator_dog_id: dog2.id, invited_dog_id: dog1.id }
    let!(:accepted) { create_list :play_date, 2, creator_dog_id: dog1.id, invited_dog_id: dog2.id, invite_status: 1 }

    let!(:dog3) { create :dog, user_id: 1 }
    let!(:dog4) { create :dog, user_id: 2 }
    let!(:pending2) { create_list :play_date, 2, creator_dog_id: dog3.id, invited_dog_id: dog4.id }
    let!(:invited2) { create_list :play_date, 2, creator_dog_id: dog4.id, invited_dog_id: dog3.id }
    let!(:accepted2) { create_list :play_date, 2, creator_dog_id: dog3.id, invited_dog_id: dog4.id, invite_status: 1 }

    it 'has the pending invoices for a user where their dog is invited' do
      expect(PlayDate.users_invited(1)).to eq(invited + invited2)
    end
  end
end
