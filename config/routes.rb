Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_dogs, only: :index

      resources :dogs, only: %i[index show create] do
        get '/play_dates', controller: :play_dates, action: :index
      end

      resources :play_dates, only: %i[index show create update]

      resources :yelp_locations, only: :index
      get '/yelp_location', controller: :yelp_locations, action: :show

      resource :dog_facts, only: :show
    end
  end
end
