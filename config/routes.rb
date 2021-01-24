Rails.application.routes.draw do
  root "users#new"
  resources :tasks
  resources :users, only: [:new, :create, :show ]
  namespace :admin do
    resources :users
  end
    resources :sessions, only: [:new, :create, :edit, :destroy]
end
