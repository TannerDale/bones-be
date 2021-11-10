class Api::V1::YelpLocationsController < ApplicationController
  def index
    validate_params
    locations = YelpLocationsFacade.dog_friendly_businesses(params[:location])

    render json: { data: locations }
  end

  def show
    location = YelpLocationsFacade.find_location_by_id(params[:id])

    render json: { data: location }
  end

  private

  def validate_params
    raise ActionController::BadRequest if invalid_params?
  end

  def invalid_params?
    params[:location].nil? || params[:location].empty?
  end
end
