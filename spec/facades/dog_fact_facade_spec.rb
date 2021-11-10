require 'rails_helper'

describe DogFactFacade do
  let(:fact) { [{ fact: 'Dogs are super cool' }] }

  before :each do
    allow(DogFactClient).to receive(:fetch).and_return(fact)
  end

  it 'gets the first dog fact' do
    result = DogFactFacade.fetch_a_fact

    expect(result).to eq(fact.first)
  end
end
