require 'rails_helper'

describe DogFactClient, :vcr do
  let(:fact) { DogFactClient.fetch }

  it 'returns a dog fact' do
    expect(fact).to be_an Array
    expect(fact.first).to be_a Hash
  end
end
