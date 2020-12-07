Rails.application.routes.draw do
  resources :comments, only: [:create, :destroy]
  devise_for :users
  get 'commentators', to: 'comments#commentators'

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
