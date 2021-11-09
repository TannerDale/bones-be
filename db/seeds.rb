# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Dog.destroy_all
PlayDate.destroy_all

100.times do
  Dog.create!(
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

Dog.all[..-2].each_with_index do |dog, i|
  PlayDate.create!(
    creator_dog_id: dog.id,
    invited_dog_id: Dog.all[i + 1].id,
    date: Date.today,
    time: Time.now,
    location_id: "12y378",
    invite_status: i % 2
  )
end
