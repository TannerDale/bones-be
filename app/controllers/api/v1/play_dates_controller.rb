class Api::V1::PlayDatesController < ApplicationController
  def index
    dog = Dog.find(params[:id])

  end

  def create
    PlayDate.create!(play_date_params)
  end

  private

  def play_date_params
    params.permit(:creator_dog_id, :invited_dog_id, :location_id, :date, :time)
  end
end
