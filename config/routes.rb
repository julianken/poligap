Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'
  resources :politicians, only: [:index, :show], param: :cid
  resources :states, only: [:index, :show], param: :state
end
