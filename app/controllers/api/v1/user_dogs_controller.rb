class Api::V1::UserDogsController < ApplicationController
  def index
    dogs = Dog.find_user_dogs(params[:user_id])
    render json: DogSerializer.new(dogs)
  end
end
