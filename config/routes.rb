Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :user_dogs, only: :index
      resources :dogs, only: [:create, :index]
      resources :yelp_locations, only: [:index]
    end
  end
end
