Rails.application.routes.draw do
  root 'index#index'
  resources :representatives, only: [:index, :show]
  resources :states, only: [:index, :show]
end
