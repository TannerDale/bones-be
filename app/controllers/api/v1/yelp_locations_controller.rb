class Api::V1::YelpLocationsController < ApplicationController
  def index
    locations = YelpLocationsFacade.dog_friendly_businesses(params[:location])
    render json: { data: locations }
  end
end
