class Api::V1::UserPetsController < ApplicationController
  def index
    pets = Pet.find_user_dogs(params[:user_id])
    render json: PetSerializer.new(pets)
  end
end