class PlayDateSerializer
  include JSONAPI::Serializer

  attributes :location_id, :date, :time
  belongs_to :creator_dog, serializer: DogSerializer
  belongs_to :invited_dog, serializer: DogSerializer
end
