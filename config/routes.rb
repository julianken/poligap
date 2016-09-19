Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'
  resources :politicians, only: [:show], param: :state
  resources :states, only: [:index, :show], param: :state
end
