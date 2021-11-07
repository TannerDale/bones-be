class Api::V1::PlayDatesController < ApplicationController
  def index
    dog = Dog.find(params[:dog_id])

    render json: DogWithPlaydatesSerializer.new(dog)
  end

  def create
    session[:user_token] = params[:token]

    create_google_event if PlayDate.create!(play_date_params)
  end

  private

  def calendar_params
    {
      email: params[:email],
      token: params[:token]
    }
  end

  def create_google_event
    event = GoogleCalendarFacade.create_event(play_date_params.merge(calendar_params))
    verify_event_creation(event)
  end

  def verify_event_creation(event)
    render json: { error: 'event creation failed' } if JSON.parse(event).key?('error')
  end

  def play_date_params
    params.require(:object).permit(:creator_dog_id, :invited_dog_id, :location_id, :date, :time)
  end
end
