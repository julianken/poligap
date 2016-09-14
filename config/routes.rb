Rails.application.routes.draw do
  devise_for :users
  root 'politicians#index'
  get 'politicians' => 'politicians#show'
end
