class PetSerializer
  include JSONAPI::Serializer
  attributes :name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id, :description
end
