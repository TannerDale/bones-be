class DogWithPlaydatesSerializer
  include JSONAPI::Serializer

  attributes :name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id, :description

  attribute :accepted_play_dates, &:accepted_play_dates

  attribute :pending_play_dates, &:pending_play_dates
end
