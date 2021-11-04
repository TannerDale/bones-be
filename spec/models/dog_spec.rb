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
  end

  describe 'instance methods' do
    let(:dogs) { create_list :dog, 4 }
    let(:dog) { dogs.first }

    before :each do
      dogs[1..2].each do |d|
        PlayDate.create(creator_dog: dog, invited_dog: d, location_id: 'adsf')
      end
      PlayDate.create(creator_dog: dogs.last, invited_dog: dog, location_id: 'adsf')
    end

    it 'has combined invited and created play dates' do
      result = dog.play_dates

      expect(result.size).to eq(3)
    end
  end
end
