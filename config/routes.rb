Rails.application.routes.draw do
  devise_for :users
  # root 'index#index'
  mount_ember_app :frontend, to: "/"
  resources :representative, only: [:index, :show], param: :cid
  resources :states, only: [:index, :show], param: :state
end
