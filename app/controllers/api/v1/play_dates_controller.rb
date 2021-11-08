class Api::V1::PlayDatesController < ApplicationController
  def index
    dog = Dog.find(params[:dog_id])

    render json: DogWithPlaydatesSerializer.new(dog)
  end

  def create
    PlayDate.create!(play_date_params)
  end

  def update
    play_date = PlayDate.find_by(creator_dog_id: params[:creator_dog], invited_dog_id: params[:invited_dog])

    play_date.update_attribute(:invite_status, params[:status].to_i)
  end

  private

  def play_date_params
    params.require(:object).permit(:creator_dog_id, :invited_dog_id, :location_id, :date, :time)
  end
end
