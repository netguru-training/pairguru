Rails.application.routes.draw do
  devise_for :users

  root 'home#welcome'
  resources :genres, only: :index
end
