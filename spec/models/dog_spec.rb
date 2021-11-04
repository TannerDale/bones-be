require 'rails_helper'

RSpec.describe Dog, type: :model do
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
      create_list(:dog, 5, user_id: 3, trained: 0)
      create_list(:dog, 8, user_id: 4, trained: 1)
      expect(Dog.find_user_dogs(3).count).to eq(5)
      expect(Dog.find_user_dogs(4).count).to eq(8)
      expect(Dog.find_user_dogs(3).first.trained).to eq('no')
      expect(Dog.find_user_dogs(4).first.trained).to eq('yes')
    end

    it '#exclude_user_dogs(id)' do
      create_list(:dog, 5, user_id: 3, trained: 0)
      create_list(:dog, 8, user_id: 4, trained: 1)
      expect(Dog.exclude_user_dogs(3).count).to eq(8)
      expect(Dog.exclude_user_dogs(4).count).to eq(5)
      expect(Dog.exclude_user_dogs(3).first.trained).to eq('yes')
      expect(Dog.exclude_user_dogs(4).first.trained).to eq('no')
    end
  end
end
