class Api::V1::DogFactsController < ApplicationController
  def show
    render json: DogFactFacade.fetch_a_fact
  end
end
