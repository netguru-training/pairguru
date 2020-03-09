Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :movies, only: [:index, :show] do
    resources :comments, except: [:index, :show]

    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  get '/top_commenters', to: 'users#top_commenters'

  namespace :api do
    namespace :v1 do
      get 'movies' => 'movies#index'
      get 'movies/:id' => 'movies#show'
    end
  end
end
