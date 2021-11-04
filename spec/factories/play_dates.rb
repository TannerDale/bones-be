FactoryBot.define do
  factory :play_date do
    creator_dog { nil }
    invited_dog { nil }
    location_id { "MyString" }
    date { "2021-11-04" }
    time { "2021-11-04 13:42:54" }
  end
end
