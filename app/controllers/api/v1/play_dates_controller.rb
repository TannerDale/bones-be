class Api::V1::PlayDatesController < ApplicationController
  def index
    dog = Dog.find(params[:dog_id])

    render json: DogWithPlaydatesSerializer.new(dog)
  end

  def create
    create_google_event if PlayDate.create!(play_date_params)
  end

  private

  def create_google_event
    event = GoogleCalendarFacade.create_event(params[:token], play_date_params, params[:email])
    verify_event_creation(event)
  end

  def verify_event_creation(event)
    failure_bruh if JSON.parse(event).key?('error')
  end

  def failure_bruh
    flash[:alert] = 'Calendar event creation failed, remember to put the car in bark'
  end

  def play_date_params
    params.require(:object).permit(:creator_dog_id, :invited_dog_id, :location_id, :date, :time)
  end
end
