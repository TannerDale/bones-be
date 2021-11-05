class DogWithPlaydatesSerializer
  include JSONAPI::Serializer

  attributes :name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id, :description

  attribute :play_dates, &:play_dates
end
