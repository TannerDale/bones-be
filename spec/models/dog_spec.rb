require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe 'relationships' do
    it { should have_many :created_play_dates }
    it { should have_many :invited_play_dates }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'enums' do
    it { should define_enum_for(:size).with_values(%i[small medium large]) }
    it { should define_enum_for(:vaccinated).with_values(%i[false true]) }
    it { should define_enum_for(:trained).with_values(%i[no yes]) }
  end

  describe 'class methods/scopes' do
    let!(:trained) { create_list :dog, 5, user_id: 3, trained: 0 }
    let!(:untrained) { create_list :dog, 8, user_id: 4, trained: 1 }

    it '#find_user_dogs(id)' do
      expect(Dog.find_user_dogs(3).count).to eq(5)
      expect(Dog.find_user_dogs(4).count).to eq(8)
      expect(Dog.find_user_dogs(3).first.trained).to eq('no')
      expect(Dog.find_user_dogs(4).first.trained).to eq('yes')
    end

    it '#exclude_user_dogs(id)' do
      expect(Dog.exclude_user_dogs(3).count).to eq(8)
      expect(Dog.exclude_user_dogs(4).count).to eq(5)
      expect(Dog.exclude_user_dogs(3).first.trained).to eq('yes')
      expect(Dog.exclude_user_dogs(4).first.trained).to eq('no')
    end

    it 'has dogs for a user' do
      expect(Dog.user_dogs(3)).to eq(trained)
    end
  end

  describe 'play dates' do
    let!(:dog1) { create :dog }
    let!(:dog2) { create :dog }
    let!(:play_date1) { create :play_date, creator_dog_id: dog1.id, invited_dog_id: dog2.id }
    let!(:play_date2) { create :play_date, creator_dog_id: dog1.id, invited_dog_id: dog2.id, invite_status: 1 }
    let!(:play_date3) { create :play_date, creator_dog_id: dog1.id, invited_dog_id: dog2.id }
    let!(:play_date4) { create :play_date, creator_dog_id: dog1.id, invited_dog_id: dog2.id, invite_status: 1 }

    it 'has all play dates' do
      result = dog1.play_dates

      expect(result).to eq([play_date1, play_date2, play_date3, play_date4])
    end

    it 'has pending play dates' do
      result = dog1.pending_play_dates

      expect(result).to eq([play_date1, play_date3])
    end

    it 'has accepted play dates' do
      result = dog1.accepted_play_dates

      expect(result).to eq([play_date2, play_date4])
    end
  end
end
