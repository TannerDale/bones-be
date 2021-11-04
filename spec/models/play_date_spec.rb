require 'rails_helper'

RSpec.describe PlayDate, type: :model do
  describe 'relationships' do
    it { should belong_to(:creator_dog) }
    it { should belong_to(:invited_dog) }
  end
end
