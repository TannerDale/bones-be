require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'enums' do
    it { should define_enum_for(:size).with_values([:small, :medium, :large]) }
    it { should define_enum_for(:vaccinated).with_values([:false, :true]) }
    it { should define_enum_for(:trained).with_values([:no, :yes]) }
  end

  describe 'class methods/scopes' do
    it '#find_user_dogs(id)' do
      create_list(:pet, 5, user_id: 3, trained: 0)
      create_list(:pet, 8, user_id: 4, trained: 1)
      expect(Pet.find_user_dogs(3).count).to eq(5)
      expect(Pet.find_user_dogs(4).count).to eq(8)
      expect(Pet.find_user_dogs(3).first.trained).to eq('no')
      expect(Pet.find_user_dogs(4).first.trained).to eq('yes')
    end

    it '#exclude_user_dogs(id)' do
      create_list(:pet, 5, user_id: 3, trained: 0)
      create_list(:pet, 8, user_id: 4, trained: 1)
      expect(Pet.exclude_user_dogs(3).count).to eq(8)
      expect(Pet.exclude_user_dogs(4).count).to eq(5)
      expect(Pet.exclude_user_dogs(3).first.trained).to eq('yes')
      expect(Pet.exclude_user_dogs(4).first.trained).to eq('no')
    end
  end
end
