class Api::V1::PetsController < ApplicationController

  def index
    per_page = params.fetch(:per_page, 20)
    if params[:page].to_i > 0
      page =  per_page * (params.fetch(:page, 1).to_i - 1)
    else
      page = 0
    end
    pets = Pet.exclude_user_dogs(params[:user_id]).limit(per_page).offset(page)
    render json: PetSerializer.new(pets)
  end

  def create
    pet = Pet.create!(pet_params)
  end

  private

  def pet_params
    params.require(:object).permit(:name, :size, :age, :breed, :vaccinated, :sex, :trained, :user_id, :description)
  end
end
