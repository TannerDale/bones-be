FactoryBot.define do
  factory :pet, class: Pet do
    name { Faker::Creature::Dog.name }
    breed { Faker::Creature::Dog.breed }
    description { Faker::Emotion.adjective }
    sex { Faker::Creature::Dog.gender }
    user_id { Faker::Number.within(range: 1..100_000) }
    age { Faker::Number.within(range: 1..50) }
    size { [0, 1, 2].sample }
    vaccinated { [0, 1].sample }
    trained { [0, 1].sample }
  end
end
