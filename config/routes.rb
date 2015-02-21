Rails.application.routes.draw do
  devise_for :users

  root 'home#welcome'
  resources :genres, only: :index
  resources :movies, only: [:index, :show]
end
