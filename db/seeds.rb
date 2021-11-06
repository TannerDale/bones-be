# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do
  Dog.create(
    name: Faker::Creature::Dog.name,
    size: %w[small medium large].sample,
    breed: Faker::Creature::Dog.breed,
    age: (1..25).to_a.sample,
    sex: Faker::Creature::Dog.gender,
    description: Faker::Creature::Dog.meme_phrase,
    vaccinated: [0, 1].sample,
    trained: [0, 1].sample,
    user_id: [1, 2, 3, 4, 5].sample
  )
end
