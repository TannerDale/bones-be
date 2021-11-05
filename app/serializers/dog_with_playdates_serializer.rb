class DogWithPlaydatesSerializer
  include JSONAPI::Serializer

  attributes :name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id, :description
  has_many :created_play_dates
  has_many :invited_play_dates
end
