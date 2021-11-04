class Api::V1::YelpLocationsController < ApplicationController
  def index
    locations = YelpLocationsFacade.dog_friendly_businesses(params[:location])
    render json: { data: locations }
  end

  def show
    location = YelpLocationsFacade.find_location_by_id(params[:id])
    render json: { data: location }
  end
end
