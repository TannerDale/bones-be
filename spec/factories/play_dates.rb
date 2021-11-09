FactoryBot.define do
  factory :play_date do
    association :creator_dog, factory: :dog
    association :invited_dog, factory: :dog

    location_id { 'MyString' }
    date { '2021-11-04' }
    time { '13:42:54' }
  end
end
