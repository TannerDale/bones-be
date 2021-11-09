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

  def create
    PlayDate.create!(play_date_params)
  end

  def update
    play_date = PlayDate.find_by(creator_dog_id: params[:creator_dog], invited_dog_id: params[:invited_dog])

    raise ActiveRecord::RecordNotFound unless play_date

    play_date.update_attribute(:invite_status, params[:status].to_i)
  end

  private

  def validate_update_params
    raise ActionController::BadRequest unless valid_status? && dogs_present?
  end

  def dogs_present?
    params[:creator_dog].present? && params[:invited_dog].present?
  end

  def valid_status?
    params[:status]&.to_i&.positive? && params[:status].to_i < 3
  end

  def play_date_params
    params.require(:object).permit(:creator_dog_id, :invited_dog_id, :location_id, :date, :time)
  end
end
