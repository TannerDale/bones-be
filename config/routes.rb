Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_dogs, only: :index

      resources :dogs, only: %i[create index]

      resources :play_dates, only: :create

      resources :yelp_locations, only: :index
      get '/yelp_location', controller: :yelp_locations, action: :show
    end
  end
end
