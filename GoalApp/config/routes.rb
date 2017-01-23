Rails.application.routes.draw do
  resource  :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :goals
  resources :comments
end
