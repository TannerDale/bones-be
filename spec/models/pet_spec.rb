require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'enums' do
    it { should define_enum_for(:size).with_values([:small, :medium, :large]) }
  end
end
