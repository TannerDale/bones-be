class Api::V1::PlayDatesController < ApplicationController
  before_action :validate_update_params, only: :update

  def index
    if params[:dog_id]
      dog = Dog.find(params[:dog_id])
      render json: DogWithPlaydatesSerializer.new(dog)
    else
      render json: PlayDateSerializer.new(PlayDateFacade.user_play_dates(params))
    end
  end

  def show
    playdate = PlayDate.find(params[:id])

    render json: PlayDateSerializer.new(playdate)
  end

  def create
    PlayDate.create!(play_date_params)
  end

  def update
    play_date = PlayDate.find(params[:id])

    play_date.update_attribute(:invite_status, params[:status].to_i)
  end

  private

  def validate_update_params
    raise ActionController::BadRequest unless valid_status?
  end

  def valid_status?
    params[:status]&.to_i&.positive? && params[:status].to_i < 3
  end

  def play_date_params
    params.require(:object).permit(:creator_dog_id, :invited_dog_id, :location_id, :date, :time)
  end
end
