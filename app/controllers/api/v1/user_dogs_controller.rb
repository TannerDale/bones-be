class Api::V1::UserDogsController < ApplicationController
  def index
    validate_params
    dogs = Dog.find_user_dogs(params[:user_id])
    render json: DogSerializer.new(dogs)
  end

  private

  def validate_params
    raise ActionController::BadRequest if invalid_params?
  end

  def invalid_params?
    params[:user_id].nil? || params[:user_id].empty?
  end
end
