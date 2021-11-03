class Api::V1::PetsController < ApplicationController

  def create
    pet = Pet.create!(pet_params)
    render json: PetSerializer.new(pet)
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id)
  end
end
