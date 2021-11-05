FactoryBot.define do
  factory :play_date do
    creator_dog_id { rand(1..100) }
    invited_dog_id { rand(1..100) }
    location_id { 'MyString' }
    date { '2021-11-04' }
    time { '13:42:54' }
  end
end
