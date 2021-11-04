require 'rails_helper'

RSpec.describe 'new dog' do
  it "can create a new dog" do
    dog_params = ({
                    name: 'Butters',
                    user_id: 1000,
                    size: 0,
                    breed: 'French Bulldog',
                    vaccinated: 1,
                    trained: 0,
                    sex: 'Male',
                    age: 2
                  })

    headers = {'CONTENT_TYPE': 'application/json'}

    post '/api/v1/dogs/', headers: headers, params: JSON.generate(object: dog_params)

    expect(response).to be_successful

    dog = Dog.all.last

    expect(Dog.count).to eq(1)
    expect(dog.name).to eq(dog_params[:name])
  end

  it "missing param returns 404" do
    dog_params = ({
                    user_id: 1000,
                    size: 0,
                    breed: 'French Bulldog',
                    vaccinated: 1,
                    trained: 0,
                    sex: 'Male',
                    age: 2
                  })

    headers = {'CONTENT_TYPE': 'application/json'}

    post '/api/v1/dogs/', headers: headers, params: JSON.generate(dog: dog_params)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
  end
end
