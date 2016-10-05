Rails.application.routes.draw do
  devise_for :users
  root 'index#index'
  resources :representatives, only: [:index, :show]
  resources :states, only: [:index, :show]
end
