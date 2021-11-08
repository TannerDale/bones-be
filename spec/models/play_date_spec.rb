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
end
