Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_dogs, only: :index

      resources :dogs, only: %i[index show create] do
        get '/play_dates', controller: :play_dates, action: :index
      end

      resources :play_dates, only: %i[create update]

      resources :yelp_locations, only: :index
      get '/yelp_location', controller: :yelp_locations, action: :show
    end
  end
end
